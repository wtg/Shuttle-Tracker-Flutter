const express = require("express");
const bodyParser = require("body-parser");
const app = express();
const fs = require("fs");
const routes = require("./routes/routes.js")(app, fs);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
  extended: true
}));



const server = app.listen(3001, () => {
  console.log("listening on port %s...", server.address().port);
});