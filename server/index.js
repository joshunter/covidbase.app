const express = require('express');
const cors = require('cors');

const app = express();

// Middleware
app.use(express.json());
app.use(cors());

const data = require('./routes/api/data');
const wData = require('./routes/api/wData');
const usStateData = require('./routes/api/usStateData');

app.use('/api/data', data);
app.use('/api/wData', wData);
app.use('/api/usStateData', usStateData);

// Handle production
if (process.env.NODE_ENV === 'production') {
  // Static folder
  app.use(express.static(__dirname + '/public/'));

  // Handle SPA
  app.get(/.*/, (req, res) => res.sendFile(__dirname + '/public/index.html'));
}

const port = process.env.PORT || 3000;

app.listen(port, () => console.log(`Server started on port ${port}`));