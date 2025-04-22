import { body } from 'express-validator';

export const validateOrganizationRoutes = [
    body('name')
    .notEmpty().withMessage('Name is Reqired'),
    body('email')
    .notEmpty().withMessage('email is Reqired'),
    body('phoneNumber')
    .notEmpty().withMessage('phone is Reqired'),
    body('website')
    .notEmpty().withMessage('website is Reqired'),
    body('address')
    .notEmpty().withMessage('address is Reqired'),
];

export const validateOrganizationEditRoute = []