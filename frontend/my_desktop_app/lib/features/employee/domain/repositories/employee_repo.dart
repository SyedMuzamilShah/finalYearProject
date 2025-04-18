import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';


abstract class EmployeeRepository {
  Future<Either<Failure, List<EmployeeEntities>>> getEmployees([EmployeeReadParams? prams]);
  Future<Either<Failure, EmployeeEntities>> addEmployee(EmployeeCreateParams prams);
  Future<Either<Failure, EmployeeEntities>> updateEmployee(EmployeeUpdateParams prams);
  Future<Either<Failure, bool>> deleteEmployee(EmployeeDeleteParams prams);

  // Future<Either<Failure, List<EmployeeEntities>>> getRequestedEmployees();
  // Future<Either<Failure, List<EmployeeEntities>>> getBlockedEmployees();
  // Future<Either<Failure, EmployeeEntities>> acceptEmployeeRequest(String employeeId);
  // Future<Either<Failure, void>> denyEmployeeRequest(String employeeId);
  // Future<Either<Failure, EmployeeEntities>> blockEmployee(String employeeId);
  // Future<Either<Failure, EmployeeEntities>> unblockEmployee(String employeeId);
}


abstract class EmployeeManagementRepository {
  Future<Either<Failure, EmployeeEntities>> employeeStatusChange(EmployeeStatusChangeParams prams);
  // Future<Either<Failure, EmployeeEntities>> acceptEmployeeRequest(String employeeId);
  // Future<Either<Failure, void>> denyEmployeeRequest(String employeeId);
  // Future<Either<Failure, EmployeeEntities>> blockEmployee(String employeeId);
  // Future<Either<Failure, EmployeeEntities>> unblockEmployee(String employeeId);
}


// // Create
// abstract class EmployeeCreateRepositories {
//   Future<Either<Failure, EmployeeEntities>> call({required EmployeeCreatePrams prams});
// }

// // Edit / Update
// abstract class EmployeeUpdateRepositories {
//   Future<Either<Failure, EmployeeEntities>> call({required EmployeeUpdatePrams prams});
// }

// // Read
// abstract class EmployeeReadRepositories {
//   Future<Either<Failure, EmployeeEntities>> call({required EmployeeReadPrams prams});
// }

// // Delete
// abstract class EmployeeDeleteRepositories {
//   Future<Either<Failure, EmployeeEntities>> call({required EmployeeDeletePrams prams});
// }