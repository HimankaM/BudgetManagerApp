import Category from "../models/CategoryModel.js";
import asyncHandler from "express-async-handler";

const createCategory = asyncHandler(async (req, res) => {
  if (req.body) {
    const category = new Category(req.body);

    await category
      .save()
      .then((data) => {
        res
          .status(201)
          .send({ success: true, message: "Category Created Successfully!" });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ success: false, message: error });
      });
  } else {
    res.status(400).send({ success: false, message: "No Data Found" });
  }
});

const getAllCategories = asyncHandler(async (req, res) => {
  await Category.find({})
    .then((data) => {
      res.status(200).send({ success: true, categories: data });
    })
    .catch((error) => {
      console.log(error);
      res.status(200).send({ success: false, message: error });
    });
});

const deleteCategory = asyncHandler(async (req, res) => {
  if (req.params.id) {
    const query = { _id: req.params.id };
    await Category.deleteOne(query)
      .then((data) => {
        res
          .status(200)
          .send({ success: true, message: "Deleted Successfully!" });
      })
      .catch((error) => {
        console.log(error);
        res.status(200).send({ success: false, message: error });
      });
  } else {
    res.status(200).send({ success: false, message: "ID Not Found!" });
  }
});

const updateCategory = asyncHandler(async (req, res) => {
  if (req.body && req.params) {
    const query = { _id: req.params.id };
    const update = {
      name: req.body.name,
      description: req.body.description,
    };

    await Category.updateOne(query, update)
      .then((result) => {
        // console.log(result.modifiedCount);
        res
          .status(200)
          .send({ success: true, message: "Category Updated Successfully!" });
      })
      .catch((error) => {
        res.status(200).send({ success: false, message: error });
      });
  } else {
    res.status(200).send({ success: false, message: "No Data Found" });
  }
});

export default {
  createCategory,
  getAllCategories,
  deleteCategory,
  updateCategory,
};
