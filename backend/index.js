const admin = require("firebase-admin");
const multer = require("multer");
const express = require("express");
const cors = require("cors");
const uuid = require("uuid-v4");
// const { initializeApp } = require("firebase/app");
// const path = require("path");
// const fs = require("fs");
// const {
//   getStorage,
//   ref,
//   getDownloadURL,
//   uploadBytesResumable,
// } = require("firebase/storage");

// const firebase = require("firebase/app");
// const firebaseConfig = {
//   apiKey: "AIzaSyDMPjh0btZKCe6WFQ3wEHr29iDcK5U9ij4",
//   authDomain: "babylogin-d368e.firebaseapp.com",
//   projectId: "babylogin-d368e",
//   storageBucket: "babylogin-d368e.appspot.com",
//   messagingSenderId: "609947077745",
//   appId: "1:609947077745:web:89fc6d51c9df98b9719fd0",
//   measurementId: "G-MS7K3J8SHG",
// };
const serviceAccount = require("../babylogin-d368e-b34070701543.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: "gs://babylogin-d368e.appspot.com",
});

const db = admin.firestore();

const app = express();
app.use(cors());
app.use(express.json());
// const storage = getStorage();

app.post("/bookAppointment", async (req, res) => {
  try {
    const { doctorname, selectedDate, selectedTime, PatientName } = req.body;
    const appointmentData = {
      doctorname,
      selectedDate,
      selectedTime,
      PatientName,
      createdAt: admin.firestore.Timestamp.now(),
    };

    const existingAppointments = await db
      .collection("appointments")
      .where("doctorname", "==", doctorname)
      .where("selectedDate", "==", selectedDate)
      .where("selectedTime", "==", selectedTime)
      .get();

    if (!existingAppointments.empty) {
      return res.status(400).send({
        message: "Appointment already booked for the selected date and time",
      });
    }
    await db.collection("appointments").add(appointmentData);
    return res
      .status(200)
      .send({ message: "Appointment booked successfully." });
  } catch (error) {
    console.error("Error booking appointment:", error);
    return res.status(500).send("Internal Server Error");
  }
});

app.post("/babyprofile:uid", async (req, res) => {
  const { babyname, Bloodgroup, Age, Weight, Height } = req.body;
  const { uid } = req.params;
  try {
    const userBabyref = admin
      .firestore()
      .collection("users")
      .doc(uid)
      .collection("babies");

    // Check if the item with the same name already exists in the user's cart
    const existingBaby = await userBabyref
      .where("babyname", "==", babyname)
      .get();

    if (existingBaby.empty) {
      // If the item doesn't exist, add it to the cart
      await userBabyref.add({
        babyname,
        Bloodgroup,
        Age,
        Weight,
        Height,
        uid,
      });
    } else {
      // If the item already exists, update the quantity
      return res.status(400).json({ message: "Baby Profile Already exists" });
    }

    return res
      .status(200)
      .json({ message: "Baby Profile has been Added Successfully" });
  } catch (error) {
    console.error("Cannot Add Baby:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.post("/signup", async (req, res) => {
  try {
    const { email, displayName, Contact, uid } = req.body;

    // Check if the user already exists
    const existingUser = await db.collection("users").doc(uid).get();

    if (existingUser.exists) {
      return res.status(400).json({ error: "User already exists" });
    } else {
      await db.collection("users").doc(uid).set({
        email,
        displayName,
        Contact,
        uid,
      });

      return res
        .status(201)
        .json({ message: "User created successfully", userId: uid });
    }

    // Create user in Firestore with UID as the document ID
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

app.post("/uploadinvo", async (req, res) => {
  try {
    const { ProductName, ProductPrice, ProductQuantity, ProductCategory } =
      req.body;
    const userCartRef = admin.firestore().collection("inventory");

    const existingItem = await userCartRef
      .where("ProductName", "==", ProductName)
      .get();

    if (existingItem.empty) {
      // If the item doesn't exist, add it to the cart
      await userCartRef.add({
        ProductName,
        ProductPrice,
        ProductQuantity,
        ProductCategory,
      });
    } else {
      // If the item already exists, update the quantity
      const existingItemId = existingItem.docs[0].id;
      const existingQuantity = existingItem.docs[0].data().quantity;

      await userCartRef.doc(existingItemId).update({
        quantity: existingQuantity + ProductQuantity,
      });
    }

    res.status(201).json({ message: "Item Added Successfully" });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ error: "Internal Server Error", details: error.message });
  }
});
app.get("/inventory", async (req, res) => {
  try {
    const category = req.query.category || "Toys";
    const snapshot = await inventoryCollection
      .where("ProductCategory", "==", category)
      .get();
    const data = snapshot.docs.map((doc) => doc.data());
    // console.log(data);
    res
      .status(200)
      .json({ success: true, Products: data, message: "API GET ALL" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Internal Server Error" });
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

    const userOrderRef = admin.firestore().collection("orders");

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
  const { itemName, price, category } = req.body;

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
        quantity: 1,
        price,
        category,
      });
    } else {
      // If the item already exists, update the quantity
      const existingItemId = existingItem.docs[0].id;
      const existingQuantity = existingItem.docs[0].data().quantity;

      await userCartRef.doc(existingItemId).update({
        quantity: existingQuantity + 1,
      });
    }

    res.status(201).json({ message: "Item added to cart successfully" });
  } catch (error) {
    console.error("Error adding item to cart:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.delete("/CartClear:uid", async (req, res) => {
  try {
    let userId = req.params.uid;
    userId = userId.substring(1);

    await deleteSubcollection(userId);
    res.status(200).json({
      success: true,
      message: `Cart subcollection for user ${userId} deleted successfully.`,
    });
  } catch (error) {
    console.error("Error deleting cart subcollection:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});
const deleteSubcollection = async (parentId) => {
  const collectionRef = admin
    .firestore()
    .collection("users")
    .doc(parentId)
    .collection("cart");
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

const inventoryCollection = admin.firestore().collection("inventory");

const bucket = admin.storage().bucket();
console.log(bucket);
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

// app.post("/uploadImage", upload.single("filename"), async (req, res) => {
//   try {
//     if (!req.file) {
//       return res.status(400).json({ error: "No file uploaded" });
//     }

//     const metadata = {
//       metadata: { firebaseStorageDownloadTokens: uuid() },
//       contentType: req.file.mimetype,
//     };

//     const blob = bucket.file(req.file.originalname);
//     const blobStream = blob.createWriteStream({
//       metadata: metadata,
//       gzip: true,
//     });

//     blobStream.on("error", (err) => {
//       console.error("Error uploading file:", err);
//       return res.status(500).json({ error: "Error uploading file" });
//     });

//     blobStream.on("finish", () => {
//       const image = `https://storage.googleapis.com/${bucket.name}/${blob.name}`;
//       return res.status(200).json({ image });
//     });

//     blobStream.end(req.file.buffer);
//   } catch (e) {
//     console.error("Exception:", e);
//     return res.status(500).json({ error: "Internal Server Error" });
//   }
// });


// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
