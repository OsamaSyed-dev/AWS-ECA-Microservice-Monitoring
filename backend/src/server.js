const express = require("express");
const cors = require("cors");
const { Pool } = require("pg");
const client = require("prom-client");
const collectDefaultMetrics = client.collectDefaultMetrics;

collectDefaultMetrics();

const app = express();
app.use(cors());
app.use(express.json());

// PostgreSQL connection
const pool = new Pool({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "postgres",
  password: process.env.DB_PASSWORD || "postgres",
  database: process.env.DB_NAME || "employeesdb",
  port: process.env.DB_PORT || 5432,
  ssl: {
    rejectUnauthorized: false
  }
});

// Test connection
pool
  .connect()
  .then(() => console.log("✅ Connected to PostgreSQL database"))
  .catch((err) => console.error("❌ Database connection failed:", err));

// Routes
app.get("/employees", async (req, res) => {
  try {
    const result = await pool.query("SELECT * FROM employees ORDER BY id ASC");
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Database error" });
  }
});

app.post("/employees", async (req, res) => {
  const { name, role } = req.body;
  if (!name || !role) return res.status(400).json({ error: "Missing fields" });

  try {
    const result = await pool.query(
      "INSERT INTO employees (name, role) VALUES ($1, $2) RETURNING *",
      [name, role]
    );
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to add employee" });
  }
});

app.delete("/employees/:id", async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query("DELETE FROM employees WHERE id = $1", [id]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Employee not found" });
    }

    res.json({ message: "Employee deleted successfully" });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Failed to delete employee" });
  }
});

const PORT = 5000;

// Expose Prometheus metrics
app.get("/metrics", async (req, res) => {
  try {
    res.set("Content-Type", client.register.contentType);
    res.end(await client.register.metrics());
  } catch (err) {
    res.status(500).end(err);
  }
});

app.listen(PORT, () => console.log(`Backend running on port ${PORT}`));
