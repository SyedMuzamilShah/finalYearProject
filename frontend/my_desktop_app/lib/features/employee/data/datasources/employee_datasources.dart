import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/core/url/url.dart';
import 'package:my_desktop_app/features/employee/data/models/response/employee_response.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';

abstract class EmployeeRemoteDataSource {
  Future<EmployeeEntities> addEmployee(Map<String, dynamic> prams);
  Future<List<EmployeeEntities>> getEmployees([Map<String, dynamic>? prams]);
  Future<EmployeeEntities> employeeStatusChange(Map<String, dynamic> prams);
  // Future<List<EmployeeEntities>> getRequestedEmployees(String organizationId);
  // Future<List<EmployeeEntities>> getBlockedEmployees(String organizationId);
  // Future<EmployeeEntities> acceptEmployeeRequest(String organizationId, String employeeId);
  // Future<void> denyEmployeeRequest(String organizationId, String employeeId);
  // Future<EmployeeEntities> blockEmployee(String organizationId, String employeeId);
  // Future<EmployeeEntities> unblockEmployee(String organizationId, String employeeId);
}

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  final ApiServices _apiServices;
  EmployeeRemoteDataSourceImpl({required ApiServices apiServices})
      : _apiServices = apiServices;

  @override
  Future<EmployeeEntities> addEmployee(Map<String, dynamic> prams) async {
    try {
      final response = await _apiServices.postRequest(
          endPoint: ServerUrl.employeeCreateRoute,
          body: prams,
          isFormData: true);
      if (response.statusCode == 201) {
        print(response.data);
        final EmployeeEntities employee =
            EmployeeResponseModel.fromJson(response.data['data']['user']);
        return employee;
      }

      throw Exception("");
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<List<EmployeeEntities>> getEmployees(
      [Map<String, dynamic>? prams]) async {
    try {
      final response = await _apiServices.getRequest(
          endPoint: ServerUrl.employeeGetRoute, queryParameters: prams);
      if (response.statusCode == 200) {

        List data = response.data['data']['user'];
      List<EmployeeEntities> createData =
          data.map((e) => EmployeeResponseModel.fromJson(e)).toList();
        return createData;
      }
      throw Exception("");
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<EmployeeEntities> employeeStatusChange(Map<String, dynamic> prams) async {
        try {
      final response = await _apiServices.postRequest(
          endPoint: ServerUrl.employeeStatusChangeRoute, body: prams);
      if (response.statusCode == 200) {

        EmployeeEntities createData =
            EmployeeResponseModel.fromJson(response.data['data']['user']);
        return createData;
      }
      throw Exception("");
    } catch (e) {
      rethrow;
    }
  }
}
