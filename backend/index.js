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
app.get("/inventory", async (req, res) => {
  try {
    const category = req.query.category || "all"; // Default to 'all' if not provided
    const snapshot = await inventoryCollection
      .where("ProductCategory", "==", req.query.category)
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
