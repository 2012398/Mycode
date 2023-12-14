const express = require("express");
const admin = require("firebase-admin");

const app = express();

// Initialize Firebase Admin SDK
const serviceAccount = require("path/to/serviceAccountKey.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://your-firebase-project-id.firebaseio.com",
});

// Define endpoint to delete the "cart" subcollection
app.delete("/delete-cart/:userId", async (req, res) => {
  try {
    const userId = req.params.userId;

    // Call the function to delete the "cart" subcollection
    await deleteSubcollection(userId, "cart");

    res
      .status(200)
      .json({
        success: true,
        message: `Cart subcollection for user ${userId} deleted successfully.`,
      });
  } catch (error) {
    console.error("Error deleting cart subcollection:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
});

// Function to delete a subcollection within a document
const deleteSubcollection = async (parentId, subcollectionName) => {
  const collectionRef = admin
    .firestore()
    .collection("users")
    .doc(parentId)
    .collection(subcollectionName);
  const batchSize = 500; // Adjust the batch size based on your needs

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

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
