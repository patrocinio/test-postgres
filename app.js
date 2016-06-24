var pg = require("pg")
var http = require("http")

if (process.env.VCAP_SERVICES) {
  var env = JSON.parse(process.env.VCAP_SERVICES);
  console.log ("Environment: " + JSON.stringify(env))
  if (env['user-provided']){
      var credentials = env['user-provided'][0]['credentials'];
    } else {
       var credentials = env['compose-postgresql-dedicated'][0]['credentials'];
    }
} else {
  var credentials = {"uri":"postgre://user:secret1@localhost:5433/db"}
}

var port = (process.env.VCAP_APP_PORT || 1337);
var host = (process.env.VCAP_APP_HOST || '0.0.0.0');

var server = http.createServer(function(req, res) {
    console.log ("Connecting to " + credentials)
    if (credentials.uri) {
       var client = new pg.Client(credentials.uri);
    } else {
       var client = new pg.Client(credentials.public_hostname)
    }
    client.connect(function(err) {
      if (err) {
        res.end("Could not connect to postgre: " + err);
      }
      client.query('SELECT NOW() AS "pgTime"', function(err, result) {
        if (err) {
          res.end("Error running query: " + err);
        }
        res.end("PG Time: " + result.rows[0].pgTime);
        client.end();
      });
    });
}).listen(port, host);
