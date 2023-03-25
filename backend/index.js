import express from "express";
import bodyParser from "body-parser";
import dotenv from "dotenv";
import cors from "cors";
// import path from "path";

import connectDB from "./src/config/db.js";
import categoryRoutes from "./src/routes/CategoryRoutes.js";
import accountRoutes from "./src/routes/AccountRoutes.js";
import transactionRoutes from "./src/routes/TransactionRoutes.js";

dotenv.config();

//connect to the database
connectDB();

const app = express();
app.use(cors());
app.use(bodyParser.json());

//routes
app.use("/api/accounts", accountRoutes);
app.use("/api/categories", categoryRoutes);
app.use("/api/transactions", transactionRoutes);

const PORT = process.env.PORT || 5000;

// const __dirname = path.resolve();

app.get("/", (req, res) => {
  res.send("Api is working");
});

app.listen(
  PORT,
  console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`)
);
