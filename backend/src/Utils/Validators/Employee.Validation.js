import { body } from 'express-validator';

export const validateEmployeeRegisterRoutes = [
    // body('email').isEmail().withMessage('Invalid email'),
    // body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
];

export const validateEmployeeLoginRoutes = [
    body('email').isEmail().withMessage('Invalid email'),
    body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
];

export const validateEmployeeChangePasswordRoutes = [
    body('name').notEmpty().withMessage('Name is required'),
    body('email').isEmail().withMessage('Invalid email'),
    body('password').notEmpty(),
];

export const validateEmployeeForgetPasswordRoutes = [
    body('email').isEmail().withMessage('Invalid email'),
];

export const validateEmployeeStatusChangeRoutes = [
    body('status').notEmpty().withMessage('Status is required'),
    body('employeeId').notEmpty().withMessage('Employee ID is required')
    .isMongoId().withMessage('Invalid Employee ID format'),
];