const express = require("express");
const cors = require("cors");

// In-memory store for events
const events = [];

// Initialize the app
const app = express();

// Middleware
app.use(cors()); // Enable CORS
app.use(express.json()); // Parse JSON body

// Routes
// Endpoint to receive callbacks
app.post("/api/callbacks/receive", (req, res) => {
  const callbackData = req.body;
  events.push(callbackData);
  res.status(200).json({ message: "Event received successfully" });
});

// Endpoint to view stored events
app.get("/api/callbacks/events", (req, res) => {
  res.status(200).json(events);
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
