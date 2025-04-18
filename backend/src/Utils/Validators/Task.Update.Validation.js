import { taskModel } from "../../Models/Task.Model";

export const validateTaskUpdateRoute = [
    body("title")
        .optional()
        .trim()
        .notEmpty()
        .withMessage("Title is required to update")
        .isLength({ min: 3, max: 50 })
        .withMessage("task title must be between 3-50 characters"),

    body("employeeId")
        .optional()
        .custom(async (employeeId) => {
            const existingUser = await taskModel.findOne({ employeeId });
            if (!existingUser) throw new Error("EmployeeId not found");
        }),

    body("description")
        .optional()
        .trim()
        .notEmpty()
        .withMessage("description is required to update")
        .isLength({ min: 3, max: 250 })
        .withMessage("task description must be between 3-250 characters"),
];