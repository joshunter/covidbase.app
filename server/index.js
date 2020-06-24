const express = require('express');
const cors = require('cors');

const app = express();

// Middleware
app.use(express.json());
app.use(cors());

const data = require('./routes/api/data');
const wData = require('./routes/api/wData');
const usData = require('./routes/api/usData');
const statesData = require('./routes/api/statesData');

app.use('/api/data', data);
app.use('/api/wData', wData);
app.use('/api/usData', usData);
app.use('/api/statesData', statesData);

// Handle production
if (process.env.NODE_ENV === 'production') {
  // Static folder
  app.use(express.static(__dirname + '/public/'));

  // Handle SPA
  app.get(/.*/, (req, res) => res.sendFile(__dirname + '/public/index.html'));
}

const port = process.env.PORT || 80;

app.listen(port, () => console.log(`Server started on port ${port}`));