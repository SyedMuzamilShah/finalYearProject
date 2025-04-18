import { body } from "express-validator";
import { taskModel } from "../../Models/Task.Model";

export const validateTaskUpdateRoute = [
  body("title")
    .optional()
    .trim()
    .notEmpty().withMessage("Title is required to update")
    .isLength({ min: 3, max: 50 }).withMessage("Task title must be between 3-50 characters"),

  body("description")
    .optional()
    .trim()
    .notEmpty().withMessage("Description is required to update")
    .isLength({ min: 3, max: 250 }).withMessage("Task description must be between 3-250 characters"),

  body("employeeId")
    .optional()
    .custom(async (employeeId) => {
      const existingUser = await taskModel.findOne({ employeeId });
      if (!existingUser) {
        throw new Error("EmployeeId not found");
      }
    }),

  body("location")
    .optional()
    .custom((value) => {
      if (typeof value !== 'object' || value.type !== 'Point' || !Array.isArray(value.coordinates)) {
        throw new Error("Location must be a GeoJSON Point with coordinates");
      }

      const [longitude, latitude] = value.coordinates;

      if (typeof longitude !== 'number' || typeof latitude !== 'number') {
        throw new Error("Coordinates must be numbers");
      }

      if (longitude < -180 || longitude > 180) {
        throw new Error("Longitude must be between -180 and 180");
      }

      if (latitude < -90 || latitude > 90) {
        throw new Error("Latitude must be between -90 and 90");
      }

      return true;
    }),

  body("dueDate")
    .optional()
    .custom((value) => {
      const dueDate = new Date(value);
      const now = new Date();
      const minDue = new Date(now.getTime() + 30 * 60000); // 30 minutes from now

      if (isNaN(dueDate.getTime())) {
        throw new Error("Invalid date format");
      }

      if (dueDate < minDue) {
        throw new Error("Due date must be at least 30 minutes from now");
      }

      return true;
    }),

  body("status")
    .optional()
    .isIn(["pending", "in-progress", "completed", "cancelled"])
    .withMessage("Status must be one of: pending, in-progress, completed, cancelled"),
];
