const updateStops = (app, fs) => {
    // variables
    const dataPath = "./data/stops.json";
  
    // READ
    app.get("/stops", (req, res) => {
      fs.readFile(dataPath, "utf8", (err, data) => {
        if (err) {
          throw err;
        }
  
        res.send(JSON.parse(data));
      });
    });
  };
  
  module.exports = updateStops;