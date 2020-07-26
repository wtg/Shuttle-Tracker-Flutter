// load up our shiny new route for updates
const updateRoutes = require("./updates");

const appRouter = (app, fs) => {
  // we've added in a default route here that handles empty routes
  // at the base API url
  app.get("/", (req, res) => {
    res.send("welcome to the development api-server");
  });

  // run our update route module here to complete the wire up
  updateRoutes(app, fs);
};

// this line is unchanged
module.exports = appRouter;