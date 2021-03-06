var express = require('express');
var app = express();
var cors = require('cors');
var mysql = require("mysql");
var con = mysql.createConnection({ host: process.env.MYSQL_HOST, user: process.env.MYSQL_USER, password: process.env.MYSQL_PASSWORD, database: process.env.MYSQL_DATABASE});

app.use(cors());
 
// mysql code

con.connect(function(err){
  if(err){
    console.log('Error connecting to db: ', err);
    return;
  }
  console.log('Connection to db established');
  con.query('CREATE TABLE IF NOT EXISTS visits (id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, ts BIGINT)',function(err) {
    if(err) throw err;
  });
});

// Request handling
app.get('/api', function (req, res) {
  // create table if not exist
  con.query('INSERT INTO visits (ts) values (?)', Date.now(),function(err, dbRes) {
    if(err) throw err;
    res.send('Hello World! You are visitor number '+dbRes.insertId);
  });
});

app.get('/health', (req, res) => {
    // your health check logic goes here
    res.status(200).send();
});

app.get('/ready', (req, res) => {
    // your readiness check logic goes here
    res.status(200).send();
});

// server
var server = app.listen(3000, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log('Example app running');
});
