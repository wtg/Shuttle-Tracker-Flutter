// load up our shiny new route for updates
const updateUpdates = require("./shuttle_updates");
const updateStops = require('./shuttle_stops')
const updateRoutes = require('./shuttle_routes')

const appRouter = (app, fs) => {
  // we've added in a default route here that handles empty routes
  // at the base API url
  app.get("/", (req, res) => {
    res.send("welcome to the development api-server");
  });

  // run our update route module here to complete the wire up
  updateUpdates(app, fs);
  updateStops(app, fs);
  updateRoutes(app, fs);
};

// this line is unchanged
module.exports = appRouter;