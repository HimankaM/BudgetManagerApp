import express from "express";
import CategoryController from "../controllers/CategoryController.js";

const router = express.Router();

router
  .route("/")
  .post(CategoryController.createCategory)
  .get(CategoryController.getAllCategories);

router.route("/:id").delete(CategoryController.deleteCategory);
router.route("/:id").patch(CategoryController.updateCategory);

export default router;
