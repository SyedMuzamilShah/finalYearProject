import { body } from 'express-validator';

export const validateEmployeeRoutes = [
    body('userName')
        .notEmpty().withMessage('Username is required')
        .isLength({ min: 3 }).withMessage('Username must be at least 3 characters'),

    body('name')
        .optional()
        .isString().withMessage('Name must be a string')
        .isLength({ min: 3 }).withMessage('Name must be at least 3 characters'),

    body('email')
        .trim()
        .notEmpty().withMessage("Email is required")
        .isEmail().withMessage('Invalid email'),

    body('password')
        .notEmpty().withMessage('Password is required')
        .isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),

    body('phoneNumber')
        .optional()
        .trim()
        .notEmpty().withMessage('Phone number field must not be empty')
        .isLength({ min: 10, max: 13 }).withMessage('Phone number must be between 10 to 13 characters'),
        // .isNumeric().withMessage('Phone number must contain only numbers'),

    body('imageUrl')
        .optional()
        .isURL().withMessage('Invalid URL format for image'),

    body('role')
        .notEmpty().withMessage('Role is required')
        .isIn(['Servent', 'Employee', 'Manager']).withMessage('Invalid role value'),

    body('organizationId')
        .notEmpty().withMessage('Organization ID is required')
        .isString().withMessage('Organization ID must be a string')
];




export const validateEmployeeGetRoutes = [
    
]