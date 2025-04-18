import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/core/services/token_service.dart';
import 'package:my_desktop_app/features/employee/data/datasources/employee_datasources.dart';
import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
import 'package:my_desktop_app/features/employee/data/repositories/employee_repo_impl.dart';
import 'package:my_desktop_app/features/employee/domain/usecases/employee_usecase.dart';
final token = {"accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2U3ZGM0MjliYzBmMzc0MGUxNGQ1MmIiLCJpYXQiOjE3NDM5MjM1MzcsImV4cCI6MTc0MzkzMDczN30.c2KI8RVOZ5UMX3ChZH96qvrdDhvocAYYREOr1Bc-T_Q", "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2U3ZGM0MjliYzBmMzc0MGUxNGQ1MmIiLCJpYXQiOjE3NDM5MjM1MzcsImV4cCI6MTc0NDAwOTkzN30.vyuSUCtQkkxnWzGtsbZPurpR7Fx2oql5qD4BXJhwRWs"};
void main () async {
  await TokenService().setToken(token);
  // EmployeeRemoteDataSourceImpl datasource = EmployeeRemoteDataSourceImpl(apiServices: ApiServices());
  // EmployeeRepository repo = EmployeeRepoImpl(dataSources: EmployeeRemoteDataSourceImpl(apiServices: ApiServices()));
  EmployeeUseCase usecase = EmployeeUseCase(
    
    repoManagementImpl: EmployeeRepoImpl(dataSources: EmployeeRemoteDataSourceImpl(apiServices: ApiServices())),
    repoImpl: EmployeeRepoImpl(dataSources: EmployeeRemoteDataSourceImpl(apiServices: ApiServices()))
    );
  try {
    // final response = await datasource.getEmployees({});
    // final response = await repo.getEmployees();
    final prams = EmployeeReadParams(
      isEmailVerified: true,
      organizationId: "ORG-UXGOLE",
      page: 1,
      limit: 10,
    );
    final response = await usecase.getEmployee(prams);
    response.fold(
      (err)=> print("Error response : ${err.message}"), 
      (succ)=> print(succ));
  }catch (e){
    print("Testing");
  }
}