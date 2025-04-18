import { STATUS_CODES } from "../../../constant.js";
import { employeeModel } from "../../Models/Employee.Model.js";
import { ErrorResponse } from "../../Utils/Error.js";

export const getEmployeeServices = async (dataObject) => {
    console.log(dataObject);
    console.log("Inside getEmployeeServices");
    const { adminId, id, organizationId, status, employeeId, isEmailVerified, role, search } = dataObject;

    try {
        // Start building the query object
        let query = {};

        // Add filters dynamically if they are provided
        if (organizationId) query.organizationId = organizationId;
        if (id) query._id = id;
        if (status){
            if (status.toLowerCase() !== 'all'){
                query.status = status.toUpperCase();
            }
        };
        if (employeeId) query.employeeId = employeeId;
        if (typeof isEmailVerified === "boolean") query.isEmailVerified = isEmailVerified;
        if (role) query.role = role;

        // Add text search if provided
        if (search) {
            query.$or = [
                { name: { $regex: search, $options: 'i' } },
                { email: { $regex: search, $options: 'i' } },
                { employeeId: { $regex: search, $options: 'i' } },
                { role : {$regex: search, $options: 'i' } }
            ];
        }
        console.log("Final query:", query);
        
        const employees = await employeeModel.find(query);
        
        console.log("Found employees:", employees.length);
        
        if (employees.length === 0) {
            return { message: "No employees found matching the criteria", employees: [] };
        }
        
        return { employees };
    } catch (error) {
        console.error("Error fetching employees:", error);

        if (error.name === "CastError") {
            throw new ErrorResponse(
                STATUS_CODES.BAD_REQUEST,
                `Invalid ID format: ${error.message}`
            );
        }

        throw new ErrorResponse(
            STATUS_CODES.INTERNAL_SERVER_ERROR,
            `Error fetching employees: ${error.message}`
        );
    }
};


export const employeeUpdateServices = async (dataObject) => {
    
}
export const employeeStatusChange = async (dataObject) => {
    const { adminId, employeeId , status } = dataObject;

    const employee = await employeeModel.findById(employeeId);
    if (!employee) {
        throw new ErrorResponse(STATUS_CODES.NOT_FOUND, 'Employee not found');
    }

    employee.status = status;
    await employee.save();
    return { employees: employee };
}