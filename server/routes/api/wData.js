const express = require('express');
const mongodb = require('mongodb');

const router = express.Router();

// Get Posts
router.get('/', async (req, res) => {
  res.set({
  "Access-Control-Allow-Origin" : "https://covidbase.app",
  "Vary" : "Origin",
  "X-Powered-By": "JH",
  "Content-Security-Policy" : "default-src 'none'",
  "X-Content-Type-Options" : "nosniff",
  "X-Frame-Options" : "DENY",
  "X-XSS-Protection" : "1; mode=block"});
  
  const posts = await loadPostsCollection();
  res.send(await posts.find({}).toArray());
});

// Add Post
router.post('/', async (req, res) => {
  res.status(401).send();
});

// Delete Post
router.delete('/:id', async (req, res) => {
  res.status(401).send({});
});

async function loadPostsCollection() {
  const client = await mongodb.MongoClient.connect(
    'mongodb://localhost:27017',
    {
      useNewUrlParser: true,
      useUnifiedTopology: true
    }
  );

  return client.db('world').collection('worldData');
}

module.exports = router;