import { employeeModel } from "../../Models/Employee.Model.js"

export const readEmployeeServices = async () => {
    try {
        const employee = await employeeModel.find();
        return employee
    }catch {

    }
}