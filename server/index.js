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

app.use(function(req, res, next) {
	res.set({
		"Access-Control-Allow-Origin" : "https://covidbase.app",
		"Vary" : "Origin",
		"X-Powered-By": "JH",
		"Content-Security-Policy" : "default-src 'none'",
		"X-Content-Type-Options" : "nosniff",
		"X-Frame-Options" : "DENY",
		"X-XSS-Protection" : "1; mode=block"});

	return next();
});

app.use(express.static(__dirname + '/public/'));
app.get(/.*/, (req, res) => res.sendFile(__dirname + '/public/index.html'));

const port = process.env.PORT || 80;

app.listen(port, () => console.log(`Server started on port ${port}`));