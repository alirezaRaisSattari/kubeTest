const express = require("express");
const app = express();
const port = 8000;
const { Client } = require("pg");

app.use("/images", express.static("images"));

const client = new Client({
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT),
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
});

client.connect();

app.set("view engine", "ejs");

// Health check endpoint
app.get("/health", (req, res) => {
  res.status(200).json({ status: "healthy" });
});

// Readiness check endpoint
app.get("/ready", (req, res) => {
  res.status(200).json({ status: "ready" });
});

app.get("/", (req, res) => res.render("home"));
app.get("/about", (req, res) => res.render("about"));
app.get("/contact", (req, res) => res.render("contact"));

app.listen(port, () =>
  console.log(`Server running at http://localhost:${port}`)
);
