import express from "express";
import TransactionController from "../controllers/TransactionController.js";

const router = express.Router();

router
  .route("/")
  .post(TransactionController.createTransaction)
  .get(TransactionController.getAllTransactions);

router.route("/:id").patch(TransactionController.updateTransaction);
router.route("/day/:date").get(TransactionController.getDailyTransactions);
router.route("/month/:year").get(TransactionController.getMonthlyTransactions);
router.route("/delete/:id").post(TransactionController.deleteTransaction);

export default router;
