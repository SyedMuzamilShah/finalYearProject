export const DB_URL = 'mongodb://localhost:27017';

export const DB_NAME = 'employeeLocationApp';
export const DB_NAME_TEST = 'employeeLocationAppTest';



export const STATUS_CODES = {
    OK: 200,
    CREATED: 201,
    SUCCESS_NO_RESPONSE: 204,
    BAD_REQUEST: 400,
    UNAUTHORIZED: 401,
    CONFLICT: 409,

    UNPROCESSABLE_ENTITY : 422, // Validation error
    FORBIDDEN: 403, // not allowed
    NOT_FOUND: 404, 
    INTERNAL_SERVER_ERROR: 500,
    SERVICE_UNAVAILABLE: 503,
  };