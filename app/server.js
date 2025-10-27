const express = require("express");
const app = express();
const port = process.env.PORT || 3000;

const APP_POOL = process.env.APP_POOL || "blue";
const RELEASE_ID = process.env.RELEASE_ID || "v1.0.0";

let chaosMode = false;

// Middleware to simulate chaos
app.use((req, res, next) => {
  if (chaosMode) {
    if (req.path === "/healthz") {
      return res.status(500).send("Chaos mode active");
    }
    // Simulate random delays or errors
    if (Math.random() < 0.7) return res.status(500).send("Chaos error");
  }
  next();
});

app.get("/version", (req, res) => {
  res.set("X-App-Pool", APP_POOL);
  res.set("X-Release-Id", RELEASE_ID);
  res.json({ version: RELEASE_ID, pool: APP_POOL });
});

app.get("/healthz", (req, res) => {
  res.send("OK");
});

app.post("/chaos/start", (req, res) => {
  chaosMode = true;
  res.send("Chaos mode enabled");
});

app.post("/chaos/stop", (req, res) => {
  chaosMode = false;
  res.send("Chaos mode disabled");
});

app.listen(port, () => {
  console.log(`App running on port ${port} (${APP_POOL})`);
});
