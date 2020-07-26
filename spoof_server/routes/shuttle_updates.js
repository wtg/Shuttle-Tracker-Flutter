const updateRoutes = (app, fs) => {
  // variables
  const dataPath = "./data/updates.json";

  // READ
  app.get("/updates", (req, res) => {
    fs.readFile(dataPath, "utf8", (err, data) => {
      if (err) {
        throw err;
      }

      res.send(JSON.parse(data));
    });
  });
};

module.exports = updateRoutes;