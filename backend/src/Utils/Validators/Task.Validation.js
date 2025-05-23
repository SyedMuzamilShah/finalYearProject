import { body, query } from 'express-validator'

export const validateTaskCreationRoute = [
  body("title")
    .notEmpty()
    .withMessage("Title is required")
    .isLength({ min: 3, max: 50 })
    .withMessage("Task title must be between 3-50 characters"),
  body("organizationId")
    .notEmpty()
    .withMessage("organization id is required"),
  body("description")
    .notEmpty()
    .withMessage("Description is required")
    .isLength({ min: 3, max: 250 })
    .withMessage("Task description must be between 3-250 characters"),

  body("location")
    .notEmpty()
    .withMessage("Location is required")
    .bail()
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
    .notEmpty()
    .withMessage("Due date is required")
    .bail()
    .custom((value) => {
      const dueDate = new Date(value);
      const now = new Date();
      const minDue = new Date(now.getTime() + 30 * 60000); // now + 30 minutes

      if (isNaN(dueDate.getTime())) {
        throw new Error("Invalid date format");
      }

      if (dueDate < minDue) {
        throw new Error("Due date must be at least 30 minutes from now");
      }

      return true;
    }),
];


export const validateTaskAssignRoute = [
  body("taskId")
    .notEmpty()
    .withMessage("Task ID is required")
    .bail()
    .isMongoId()
    .withMessage("Invalid Task ID format"),

  body("employeesId")
    .isArray({ min: 1 })
    .withMessage("employeesId must be a non-empty array"),

  body("employeesId.*.employeeId")
    .notEmpty()
    .withMessage("Employee ID is required")
    .bail()
    .isMongoId()
    .withMessage("Each employeeId must be a valid MongoDB ObjectId"),

  body("employeesId.*.pictureAllowed")
    .optional()
    .isBoolean()
    .withMessage("pictureAllowed must be a boolean"),
];

export const validateTaskGetRoute = [
  query("organizationId")
    .notEmpty()
    .withMessage("Organization id is required")
    .bail()
    .isMongoId()
    .withMessage("invalid Organization id")
]

export const validateTaskUpdateRoute = [
  body("taskId")
    .notEmpty()
    .withMessage("task id is required")
    .bail()
    .isMongoId()
    .withMessage("task id is invalid"),
  body("title")
    .optional()
    .notEmpty()
    .withMessage("Title is required")
    .isLength({ min: 3, max: 50 })
    .withMessage("Task title must be between 3-50 characters"),
  body("organizationId")
    .optional()

    .notEmpty()
    .withMessage("organization id is required"),
  body("description")
    .optional()

    .notEmpty()
    .withMessage("Description is required")
    .isLength({ min: 3, max: 250 })
    .withMessage("Task description must be between 3-250 characters"),

  body("location")
    .optional()

    .notEmpty()
    .withMessage("Location is required")
    .bail()
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

    .notEmpty()
    .withMessage("Due date is required")
    .bail()
    .custom((value) => {
      const dueDate = new Date(value);
      const now = new Date();
      const minDue = new Date(now.getTime() + 30 * 60000); // now + 30 minutes

      if (isNaN(dueDate.getTime())) {
        throw new Error("Invalid date format");
      }

      if (dueDate < minDue) {
        throw new Error("Due date must be at least 30 minutes from now");
      }

      return true;
    }),
]

export const validateTaskDeleteRoute = [
  query("taskId")
  .notEmpty()
  .withMessage("Must be provide the id")
  .isMongoId()
  .withMessage("Invalid id provided")
]

export const validateTaskStatusChangeRoute = []

export const validateTaskVerifiedRoute = [
  query("taskId")
    .notEmpty()
    .withMessage("Task ID is required")
    .isMongoId()
    .withMessage("Invalid Task ID format"),

  query("employeesId")
    .custom((value) => {
      // Convert employeesId into an array if it's a single value
      if (typeof value === "string") {
        return [value];  // Return as an array
      }
      if (!Array.isArray(value)) {
        throw new Error("employeesId must be an array");
      }
      return value;
    })
    .withMessage("employeesId must be an array or a single value"),

  query("employeesId.*")
    .isMongoId()
    .withMessage("Each employee ID must be a valid MongoDB ObjectId"),
];
