const admin = require("firebase-admin");
const multer = require("multer");
const express = require("express");
const cors = require("cors");
const uuid = require("uuid-v4");
// const { initializeApp } = require("firebase/app");
// const path = require("path");
// const fs = require("fs");
const {
  getStorage,
  ref,
  getDownloadURL,
  uploadBytesResumable,
} = require("firebase/storage");

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
  databaseURL: "https://default.firebaseio.com",
});

const db = admin.firestore();

const app = express();
app.use(cors());
app.use(express.json());
// const storage = getStorage();
//upload video start

const videoStorage = multer.memoryStorage(); // Store files in memory before uploading to Firebase Storage

const videoUpload = multer({ storage: videoStorage });

app.post("/uploadVideo", videoUpload.single("video"), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: "No file uploaded" });
    }

    // Upload file to Firebase Storage
    const file = req.file;
    const blob = bucket.file("Video/" + file.originalname);

    const blobStream = blob.createWriteStream({
      metadata: {
        contentType: "video/mp4",
        metadata: {
          firebaseStorageDownloadTokens: uuid(),
        },
      },
      gzip: true,
    });

    blobStream.on("error", (err) => {
      console.error("Error uploading video:", err);
      return res.status(500).json({ error: "Internal Server Error" });
    });

    blobStream.on("finish", () => {
      const videoUrl = `https://firebasestorage.googleapis.com/v0/b/${
        bucket.name
      }/o/Video%2F${encodeURIComponent(file.originalname)}?alt=media&token=${
        blob.metadata.metadata.firebaseStorageDownloadTokens
      }`;
      return res.status(200).json({ videoUrl });
    });

    blobStream.end(file.buffer);
  } catch (error) {
    console.error("Error uploading video:", error);
    return res.status(500).json({ error: "Internal Server Error" });
  }
});

// upload video end
//fetch orders
app.get("/orders", async (req, res) => {
  try {
    const ordersRef = admin.firestore().collection("orders");
    const snapshot = await ordersRef.get();

    if (snapshot.empty) {
      return res.status(404).json({ error: "No orders found" });
    }

    const orders = [];
    snapshot.forEach((doc) => {
      orders.push({
        id: doc.id,
        data: doc.data(),
      });
    });

    res.status(200).json({ orders });
  } catch (error) {
    console.error("Error fetching orders:", error);
    res.status(500).json({ error: "Internal server error" });
  }
});

//complete
//upload image start
const bucket = admin.storage().bucket();
// console.log(bucket);
const storage = multer.memoryStorage();
const upload = multer({ storage: storage });

app.post("/uploadImage", upload.single("filename"), async (req, res) => {
  const { filename } = req.body;
  try {
    if (!req.file) {
      return res.status(400).json({ error: "No file uploaded" });
    }

    const metadata = {
      // metadata: { firebaseStorageDownloadTokens: uuid() },
      contentType: "image/jpeg",
    };
    // console.log(metadata);

    // const blob = bucket.file(req.file.originalname);
    const blob = bucket.file("Inventory/" + filename);
    const blobStream = blob.createWriteStream({
      metadata: metadata,
      gzip: true,
    });

    // console.log(blobStream);

    blobStream.on("error", (err) => {
      console.error("Error uploading file:", err);
      return res.status(500).json({ error: "Error uploading file" });
    });

    blobStream.on("finish", () => {
      const image = `https://storage.googleapis.com/${bucket.name}/${blob.name}`;
      return res.status(200).json({ image });
    });

    blobStream.end(req.file.buffer);
  } catch (e) {
    console.error("Exception:", e);
    return res.status(500).json({ error: "Internal Server Error" });
  }
});
//upload image end
// get patient with my chat
app.post("/userDetails", async (req, res) => {
  const userIds = req.body.userIds; // Assuming userIds is an array of user IDs

  try {
    const userDetails = [];
    for (const userId of userIds) {
      const userDoc = await db.collection("users").doc(userId).get();
      if (userDoc.exists) {
        const userData = userDoc.data();
        userDetails.push(userData);
      }
    }

    res.json(userDetails);
  } catch (error) {
    console.error("Error fetching user details:", error);
    res.status(500).json({ error: "Error fetching user details" });
  }
});
// get patient with my chat ended

//fetch all doctor chats
app.get("/chatRoomIds/:userId", async (req, res) => {
  const userId = req.params.userId;

  try {
    const userRef = db.collection("users").doc(userId);
    const userDoc = await userRef.get();

    if (!userDoc.exists) {
      throw new Error("User not found");
    }

    const userData = userDoc.data();
    const chatRoomIds = userData["chatRoomId"] || []; // Get the chatRoomId array or an empty array if it doesn't exist
    // const chatRoomPatient = userData["user"] || []; // Get the chatRoomId array or an empty array if it doesn't exist
    // console.log(chatRoomIds);
    return res.json(chatRoomIds);
  } catch (error) {
    console.error("Error fetching chatRoomIds:", error);
    return res.status(500).json({ error: "Error fetching chatRoomIds" });
  }
});

//fetching complete
//get appointments

app.get("/get-appointments/:doctorname", (req, res) => {
  const doctorname = req.params.doctorname;
  async function fetchAppointments() {
    const querySnapshot = await db
      .collection("appointments")
      .where("doctorname", "==", doctorname)
      .get();
    const appointments = [];
    querySnapshot.forEach((doc) => {
      appointments.push(doc.data());
    });
    return appointments;
  }

  fetchAppointments()
    .then((appointments) => {
      // console.log(doctors);
      return res.status(200).json(appointments);
    })
    .catch((error) => {
      return res.status(400).json(error);
      //  console.log(error);
    });
});

//complete

//get babies
// app.get("/get-baby/:parent", (req, res) => {
//   const parent = req.params.parent;
//   console.log(parent);
//   async function fetchParent() {
//     const userRef = db.collection("users").where("displayName", "==", 'Zawat Masta');
//     const querySnapshot = await userRef.get();

//     const parentt = [];
//     querySnapshot.forEach(async (userDoc) => {
//       // Accessing the subcollection "babies" for each user
//       const babiesRef = userDoc.ref.collection("babies");
//       const babiesSnapshot = await babiesRef.get();
//       babiesSnapshot.forEach((babyDoc) => {
//         parentt.push(babyDoc.data());
//       });
//     });
//     return parentt;
//   }

//   fetchParent()
//     .then((parentt) => {
//       return res.status(200).json(parentt);
//     })
//     .catch((error) => {
//       return res.status(400).json(error);
//     });
// });

app.get("/get-baby/:parent", async (req, res) => {
  try {
    const parent = req.params.parent;
    console.log(parent);

    const userQuerySnapshot = await db
      .collection("users")
      .where("displayName", "==", parent)
      .get();

    if (userQuerySnapshot.empty) {
      return res.status(404).json({ error: "Parent not found" });
    }

    const parentt = [];

    await Promise.all(
      userQuerySnapshot.docs.map(async (userDoc) => {
        const babiesQuerySnapshot = await userDoc.ref
          .collection("babies")
          .get();
        babiesQuerySnapshot.forEach((babyDoc) => {
          parentt.push(babyDoc.data());
        });
      })
    );

    return res.status(200).json(parentt);
  } catch (error) {
    console.error("Error:", error);
    return res.status(500).json({ error: "Internal server error" });
  }
});

//complete
// get all doctors
app.get("/get-doctors", (req, res) => {
  async function fetchDoctors() {
    const querySnapshot = await db
      .collection("users")
      .where("role", "==", "doctor")
      .get();
    const doctors = [];
    querySnapshot.forEach((doc) => {
      doctors.push(doc.data());
    });
    return doctors;
  }

  fetchDoctors()
    .then((doctors) => {
      // console.log(doctors);
      return res.status(200).json(doctors);
    })
    .catch((error) => {
      return res.status(400).json(error);
      //  console.log(error);
    });
});
// doctors api ended

// chat api start
async function updateUserField(userId, fieldName, fieldValue, messageid) {
  const userRef = db.collection("users").doc(userId);
  await userRef.update({
    [fieldName]: admin.firestore.FieldValue.arrayUnion({
      [fieldName]: fieldValue,
      user: messageid,
    }),
  });
}
app.post("/send-message", async (req, res) => {
  const { DoctorId, PatientId, content, SenderId } = req.body;
  console.log(DoctorId, PatientId, content, SenderId);

  const chatRoomId = DoctorId + "_" + PatientId;
  // Push message to the appropriate collection in Firestore
  //
  console.log(chatRoomId);
  //
  const messagesRef = db.collection(`chats/${chatRoomId}/messages`);
  const timestamp = admin.firestore.Timestamp.now();
  messagesRef
    .add({
      DoctorId,
      PatientId,
      timestamp,
      SenderId,
      content,
    })
    .then(() => {
      res.status(200).send("Message sent successfully");
      updateUserField(DoctorId, "chatRoomId", chatRoomId, PatientId)
        .then(() => {
          console.log("User field updated successfully.");
        })
        .catch((error) => {
          console.error("Error updating user field:", error);
        });

      updateUserField(PatientId, "chatRoomId", chatRoomId, DoctorId)
        .then(() => {
          console.log("User field updated successfully.");
        })
        .catch((error) => {
          console.error("Error updating user field:", error);
        });
    })
    .catch((error) => {
      console.error("Error sending message:", error);
      res.status(500).send("Error sending message");
    });
});

// Route to get messages
app.get("/get-messages/:chatRoomId", (req, res) => {
  const chatRoomId = req.params.chatRoomId;
  // console.log(chatRoomId);
  // Retrieve messages from the collection in Firestore
  const messagesRef = db.collection(`chats/${chatRoomId}/messages`);
  messagesRef
    .orderBy("timestamp")
    .get()
    .then((snapshot) => {
      const messages = [];
      snapshot.forEach((doc) => {
        messages.push(doc.data());
      });
      res.status(200).json(messages);
    })
    .catch((error) => {
      console.error("Error getting messages:", error);
      res.status(500).send("Error getting messages");
    });
});

// chat api end

app.get("/readData", async (req, res) => {
  try {
    const snapshot = await db.collection("users").get();
    const data = [];
    snapshot.forEach((doc) => {
      data.push(doc.data());
    });
    res.json(data);
  } catch (error) {
    console.error("Error fetching data:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

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
    const { email, displayName, Contact, uid, role } = req.body;

    // Check if the user already exists
    const existingUser = await db.collection("users").doc(uid).get();

    if (existingUser.exists) {
      return res.status(400).json({ error: "User already exists" });
    } else {
      await db.collection("users").doc(uid).set({
        email,
        displayName,
        role,
        Contact,
        uid,
      });

      return res
        .status(200)
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
    const {
      ProductName,
      ProductPrice,
      ProductQuantity,
      ProductCategory,
      imageurl,
    } = req.body;

    const userCartRef = admin.firestore().collection("inventory");

    const existingItemQuery = await userCartRef
      .where("ProductName", "==", ProductName)
      .get();

    if (!existingItemQuery.empty) {
      // If product already exists, update the quantity and price
      const existingItemDoc = existingItemQuery.docs[0];
      const existingQuantity = existingItemDoc.data().ProductQuantity;
      const existingPrice = existingItemDoc.data().ProductPrice;

      await existingItemDoc.ref.update({
        ProductQuantity: existingQuantity + ProductQuantity,
        ProductPrice: ProductPrice, // Updating price to the average
      });
      //
      return res
        .status(201)
        .json({ message: "Quantity and price updated successfully" });
    } else {
      // If product does not exist, add a new document
      await userCartRef.add({
        ProductName,
        ProductPrice,
        ProductQuantity,
        ProductCategory,
        imageurl,
      });
      return res.status(200).json({ message: "Item Added Successfully" });
    }
  } catch (error) {
    console.error(error);
    return res
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

    return res
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

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
