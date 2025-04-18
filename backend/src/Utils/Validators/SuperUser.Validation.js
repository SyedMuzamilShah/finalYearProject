
export const validateSuperUserRegisterRoutes = [
    body('email').isEmail().withMessage('Invalid email'),
    body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
];

export const validateSuperUserLoginRoutes = [
    body('email').isEmail().withMessage('Invalid email'),
    body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
];

export const validateSuperUserChangePasswordRoutes = [
    body('oldPassword').notEmpty().withMessage('Old password is required'),
    body('password').notEmpty().withMessage('New password is required'),
];

export const validateSuperUserForgetPasswordRoutes = [
    body('email').isEmail().withMessage('Invalid email'),
];