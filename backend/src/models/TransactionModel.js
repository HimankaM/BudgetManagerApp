import mongoose from "mongoose";

const transactionModel = mongoose.Schema(
  {
    date: {
      type: Date,
      required: true,
    },
    amount: {
      type: Number,
      required: true,
    },
    type: {
      type: String,
      required: true,
    },
    description: {
      type: String,
      required: false,
    },
    account: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "Account"
    },
    category: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
      ref: "Category"
    },
  },
  {
    timestamps: true,
  }
);

const Transaction = mongoose.model("Transaction", transactionModel);
export default Transaction;
