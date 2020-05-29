const express = require('express');
const mongodb = require('mongodb');

const router = express.Router();

// Get Posts
router.get('/', async (req, res) => {
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

  return client.db('world').collection('countryData');
}

module.exports = router;