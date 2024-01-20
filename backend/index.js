const express = require("express");
const admin = require("firebase-admin");
const cors = require("cors");

// Initialize Firebase Admin SDK
const serviceAccount = require("../babylogin-d368e-b34070701543.json"); // replace with your actual path
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const app = express();
app.use(cors());
app.use(express.json());

// Firestore reference
const db = admin.firestore();

// Signup endpoint
app.post("/signup", async (req, res) => {
  try {
    const { email, displayName, Contact, uid } = req.body;

    // Check if the user already exists
    const existingUser = await db.collection("users").doc(uid).get();

    if (existingUser.exists) {
      return res.status(400).json({ error: "User already exists" });
    }

    // Create user in Firestore with UID as the document ID
    await db.collection("users").doc(uid).set({
      email,

      displayName,
      Contact,
      uid,
    });

    res.status(201).json({ message: "User created successfully", userId: uid });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
app.post("/uploadinvo", async (req, res) => {
  try {
    console.log("Received uploadinvo request:", req.body);

    const { ProductName, ProductPrice, ProductQuantity, ProductCategory } =
      req.body;

    await db.collection("inventory").add({
      ProductName,
      ProductPrice,
      ProductQuantity,
      ProductCategory,
    });

    res.status(201).json({ message: "Item Added Successfully" });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "Internal Server Error", details: error.message });
  }
});
app.post("/placeorder/:userId", async (req, res) => {
  const { userId } = req.params;
  const { Name, contact, address, subtotal } = req.body;

  try {
    console.log(userId);
    const userCartRef = admin
      .firestore()
      .collection("users")
      .doc(userId)
      .collection("cart");

    const userOrderRef = admin
      .firestore()
      .collection("orders");

    // Get all items from the user's cart
    const cartItems = await userCartRef.get();
    const items = [];
    let total = 0;
    // Move items from the cart to the order
    cartItems.forEach((doc) => {
      const { itemName, quantity, price, category } = doc.data();
      const itemTotal = quantity * price; // Calculate total for each item
      total += itemTotal; // Add to the overall total
      items.push({ itemName, quantity, price, category, itemTotal });
    });

    if (items.length === 0) {
      return res
        .status(400)
        .json({ error: "Cart is empty. Cannot place an order." });
    }

    // Create a new order document in the user's orders collection
    const orderDoc = await userOrderRef.add({
      Name,
      address,
      contact,
      subtotal,
      items,
      total,
      timestamp: admin.firestore.FieldValue.serverTimestamp(),
    });

    // Clear the user's cart by deleting all items
    cartItems.forEach((doc) => {
      userCartRef.doc(doc.id).delete();
    });

    res.status(201).json({
      message: "Order placed successfully",
      orderId: orderDoc.id,
      total,
    });
  } catch (error) {
    console.error("Error placing order:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.post("/add-to-cart:userId", async (req, res) => {
  const { userId } = req.params;
  const { itemName, quantity, price, category } = req.body;

  try {
    const userCartRef = admin
      .firestore()
      .collection("users")
      .doc(userId)
      .collection("cart");

    // Check if the item with the same name already exists in the user's cart
    const existingItem = await userCartRef
      .where("itemName", "==", itemName)
      .get();

    if (existingItem.empty) {
      // If the item doesn't exist, add it to the cart
      await userCartRef.add({
        itemName,
        quantity,
        price,
        category,
      });
    } else {
      // If the item already exists, update the quantity
      const existingItemId = existingItem.docs[0].id;
      const existingQuantity = existingItem.docs[0].data().quantity;

      await userCartRef.doc(existingItemId).update({
        quantity: existingQuantity + quantity,
      });
    }

    res.status(201).json({ message: "Item added to cart successfully" });
  } catch (error) {
    console.error("Error adding item to cart:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

// app.post("/add-to-cart:userId", async (req, res) => {
//   const { userId } = req.params;
//   const { itemName, quantity, price, category } = req.body;

//   try {
//     console.log(userId);
//     // Get a reference to the user's cart in the Firebase collection
//     const userCartRef = admin
//       .firestore()
//       .collection("users")
//       .doc(userId)
//       .collection("cart");

//     // Add the item to the user's cart
//     await userCartRef.add({
//       itemName,
//       quantity,
//       price,
//       category,
//     });

//     res
//       .status(201)
//       .json({ succes: "Success", message: "Item added to cart successfully" });
//   } catch (error) {
//     console.error("Error adding item to cart:", error);
//     res.status(500).json({ error: "Internal server error" });
//   }
// });

// const Product = mongoose.model("inventory", InventorySchema);

// app.get("/getAll", async (req, res) => {
//   try {
//     const data = await Product.find();
//     console.log("Products: ", data);
//     res
//       .status(200)
//       .json({ success: true, Products: data, message: "API GET ALL" });
//     // res.json(data);
//   } catch (error) {
//     console.error("Error fetching product by ID:", error);
//     res.status(500).json({ message: error.message });
//   }
// });
app.delete("/CartClear:uid", async (req, res) => {
  try {
    let userId = req.params.uid;
    userId = userId.substring(1);
    console.log(userId);
    await deleteSubcollection(userId, "cart");
    res.status(200).json({
      success: true,
      message: `Cart subcollection for user ${userId} deleted successfully.`,
    });
  } catch (error) {
    console.error("Error deleting cart subcollection:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
const deleteSubcollection = async (parentId, subcollectionName) => {
  const collectionRef = admin
    .firestore()
    .collection("users")
    .doc(parentId)
    .collection(subcollectionName);
  const batchSize = 100; // Adjust the batch size based on your needs

  const query = collectionRef.orderBy("__name__").limit(batchSize);

  return new Promise((resolve, reject) => {
    deleteQueryBatch(query, batchSize, resolve, reject);
  });
};

// Function to delete a query batch
const deleteQueryBatch = (query, batchSize, resolve, reject) => {
  query
    .get()
    .then((snapshot) => {
      if (snapshot.size === 0) {
        return 0;
      }

      const batch = admin.firestore().batch();
      snapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
      });

      return batch.commit().then(() => snapshot.size);
    })
    .then((numDeleted) => {
      if (numDeleted === 0) {
        resolve();
        return;
      }

      process.nextTick(() => {
        deleteQueryBatch(query, batchSize, resolve, reject);
      });
    })
    .catch(reject);
};

app.get("/CartItems:uid", async (req, res) => {
  try {
    let uid = req.params.uid;
    uid = uid.substring(1);

    console.log(uid);
    const snapshot = await admin
      .firestore()
      .collection("users")
      .doc(uid)
      .collection("cart")
      .get();
    const data = snapshot.docs.map((doc) => doc.data());
    console.log(data);
    res
      .status(200)
      .json({ success: true, Products: data, message: "API GET Cart" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.get("/inventory", async (req, res) => {
  try {
    const category = req.query.category || "all"; // Default to 'all' if not provided
    const snapshot = await inventoryCollection
      .where("ProductCategory", "==", category)
      .get();
    const data = snapshot.docs.map((doc) => doc.data());
    console.log(data);
    res
      .status(200)
      .json({ success: true, Products: data, message: "API GET ALL" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

const inventoryCollection = admin.firestore().collection("inventory");
// app.get("/inventory", async (req, res) => {
//   try {
//     const snapshot = await inventoryCollection.get();
//     const data = snapshot.docs.map((doc) => doc.data());
//     console.log(data);
//     res
//       .status(200)
//       .json({ success: true, Products: data, message: "API GET ALL" });
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ error: "Internal Server Error" });
//   }
// });
// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
