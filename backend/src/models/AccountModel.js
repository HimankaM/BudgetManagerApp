import mongoose from "mongoose";

const accountModel = mongoose.Schema(
  {
    name: {
      type: String,
      required: true,
    },
    amount: {
      default: 0,
      type: Number,
    },
    description: {
      type: String,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

const Account = mongoose.model("Account", accountModel);
export default Account;
