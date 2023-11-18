const express = require('express');
const admin = require('firebase-admin');
const cors = require('cors');
// Initialize Firebase Admin SDK
const serviceAccount = require('../babylogin-d368e-b34070701543.json'); // replace with your actual path
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const app = express();
app.use(cors());
app.use(express.json());

// Firestore reference
const db = admin.firestore();

// Signup endpoint
app.post('/signup', async (req, res) => {
  try {
    const { email, password, displayName,Contact } = req.body;

    // Create user in Firestore
    const userRef = await db.collection('users').add({
      email,
      password,
      displayName,
      Contact
    });
    const existingUser = await db.collection('users').where('email', '==', email).get();

    if (!existingUser.empty) {
      return res.status(400).json({ error: 'Email already exists' });
    }
    res.status(201).json({ message: 'User created successfully', userId: userRef.id });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
