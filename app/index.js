var compression = require('compression');
var express = require('express');
var history = require('connect-history-api-fallback');
var app = express();

// Middleware for serving '/dist' directory
app.use(compression());

const staticFileMiddleware = express.static('dist', {
  setHeaders: function(res, path) {
	res.set({
	"X-Powered-By": "JH",
	"Content-Security-Policy" : "default-src 'self' https://db.covidbase.app; font-src https://fonts.gstatic.com; img-src 'self' data:",
	"X-Content-Type-Options" : "nosniff",
	"X-Frame-Options" : "DENY",
	"X-XSS-Protection" : "1; mode=block"});
  }});

// 1st call for unredirected requests 
app.use(staticFileMiddleware);

// Support history api 
app.use(history());

// 2nd call for redirected requests
app.use(staticFileMiddleware);

app.listen(8080, function () {
  console.log('Listening on port 8080');
});