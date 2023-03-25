import Transaction from "../models/TransactionModel.js";
import Account from "../models/AccountModel.js";
import asyncHandler from "express-async-handler";

const createTransaction = asyncHandler(async (req, res) => {
  if (req.body) {
    const data = req.body;
    const transaction = new Transaction(data);

    await transaction
      .save()
      .then(async (resData) => {
        //update account
        var transactionType = data.type;
        var transactionAmount = 0;

        // Expense
        if (transactionType == "Expense") {
          transactionAmount = -data.amount;
        } else {
          // Income
          transactionAmount = data.amount;
        }

        const query = { _id: data.account };
        const update = {
          $inc: { amount: transactionAmount },
        };

        await Account.updateOne(query, update)
          .then(
            res.status(201).send({
              success: true,
              message: "Transaction Created Successfully!",
            })
          )
          .catch((error) => {
            console.log(error);
            res.status(200).send({ success: false, message: error });
          });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ success: false, message: error });
      });
  } else {
    res.status(400).send({ success: false, message: "No Data Found" });
  }
});

const getAllTransactions = asyncHandler(async (req, res) => {
  await Transaction.find({})
    .populate("category")
    .populate("account")
    .then((data) => {
      res.status(200).send({ success: true, transactions: data });
    })
    .catch((error) => {
      console.log(error);
      res.status(200).send({ success: false, message: error });
    });
});

// Amount,Type,Account body data
const deleteTransaction = asyncHandler(async (req, res) => {
  if (req.params.id && req.body) {
    var data = req.body;
    //update account
    var transactionType = data.type;
    var transactionAmount = 0;

    // Expense Added to account
    if (transactionType == "Expense") {
      transactionAmount = data.amount;
    } else {
      // Income Deducted to account
      transactionAmount = -data.amount;
    }

    const updateQuery = { _id: data.account };
    const update = {
      $inc: { amount: transactionAmount },
    };

    //update account balance
    const delete_query = { _id: req.params.id };
    await Account.updateOne(updateQuery, update)
      .then(async (updateRes) => {
        //delete transaction
        await Transaction.deleteOne(delete_query)
          .then((data) => {
            res
              .status(200)
              .send({ success: true, message: "Deleted Successfully!" });
          })
          .catch((error) => {
            console.log(error);
            res.status(200).send({ success: false, message: error });
          });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ success: false, message: error });
      });
  } else {
    res.status(200).send({ success: false, message: "ID Not Found!" });
  }
});

const getDailyTransactions = asyncHandler(async (req, res) => {
  if (req.params) {
    var date = req.params.date;
    var search_month = parseInt(date.split("-", 2)[0]);
    var search_year = parseInt(date.split("-", 2)[1]);
    console.log(search_year, search_month);

    const query2 = {
      $project: {
        year: { $year: "$date" },
        month: { $month: "$date" },
        day: { $dayOfMonth: "$date" },
        _id: 1,
        date: 1,
        type: 1,
        amount: 1,
        account: 1,
        category: 1,
        description: 1,
      },
    };
    const query3 = {
      $match: { month: search_month, year: search_year },
    };
    const query5 = {
      $lookup: {
        from: "accounts",
        localField: "account",
        foreignField: "_id",
        as: "account",
      },
    };
    const query6 = {
      $unwind: "$account",
    };
    const query7 = {
      $lookup: {
        from: "categories",
        localField: "category",
        foreignField: "_id",
        as: "category",
      },
    };
    const query8 = {
      $unwind: "$category",
    };

    const query9 = {
      $group: {
        _id: {
          day: { $dayOfMonth: "$date" },
          month: { $month: "$date" },
          year: { $year: "$date" },
        },
        transactions: {
          $push: {
            _id: "$_id",
            date: "$date",
            type: "$type",
            amount: "$amount",
            account: "$account",
            category: "$category",
            description: "$description",
          },
        },
      },
    };

    const query1 = { $sort: { "_id": 1 } };

    await Transaction.aggregate([
      query2,
      query3,
      query5,
      query6,
      query7,
      query8,
      query9,
      query1,
    ])
      .then((data) => {
        res.status(200).send({ success: true, transactions: data });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ success: false, message: error });
      });
  } else {
    res.status(200).send({ success: false, message: "Date Not Found" });
  }
});

const getMonthlyTransactions = asyncHandler(async (req, res) => {
  if (req.params) {
    var search_year = parseInt(req.params.year);
    console.log(search_year);

    const query2 = {
      $project: {
        year: { $year: "$date" },
        month: { $month: "$date" },
        _id: 1,
        date: 1,
        type: 1,
        amount: 1,
        account: 1,
        category: 1,
        description: 1,
      },
    };
    const query3 = {
      $match: { year: search_year },
    };
    const query5 = {
      $lookup: {
        from: "accounts",
        localField: "account",
        foreignField: "_id",
        as: "account",
      },
    };
    const query6 = {
      $unwind: "$account",
    };
    const query7 = {
      $lookup: {
        from: "categories",
        localField: "category",
        foreignField: "_id",
        as: "category",
      },
    };
    const query8 = {
      $unwind: "$category",
    };

    const query9 = {
      $group: {
        _id: {
          month: { $month: "$date" },
          year: { $year: "$date" },
        },
        transactions: {
          $push: {
            _id: "$_id",
            date: "$date",
            type: "$type",
            amount: "$amount",
            account: "$account",
            category: "$category",
            description: "$description",
          },
        },
      },
    };

    const query1 = { $sort: { "_id": 1 } };

    await Transaction.aggregate([
      query2,
      query3,
      query5,
      query6,
      query7,
      query8,
      query9,
      query1,
    ])
      .then((data) => {
        res.status(200).send({ success: true, transactions: data });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ success: false, message: error });
      });
  } else {
    res.status(200).send({ success: false, message: "Date Not Found" });
  }
});

const updateTransaction = asyncHandler(async (req, res) => {
  if (req.body && req.params) {

    const query = { _id: req.params.id };
    const update = {
      date: req.body.date,
      description: req.body.description,
    };

    await Transaction.updateOne(query, update)
      .then((result) => {
        // console.log(result.modifiedCount);
        res
          .status(200)
          .send({
            success: true,
            message: "Transaction Updated Successfully!",
          });
      })
      .catch((error) => {
        res.status(200).send({ success: false, message: error });
      });
  } else {
    res.status(400).send({ success: false, message: "No Data Found" });
  }
});

export default {
  createTransaction,
  getAllTransactions,
  deleteTransaction,
  getDailyTransactions,
  getMonthlyTransactions,
  updateTransaction,
};
