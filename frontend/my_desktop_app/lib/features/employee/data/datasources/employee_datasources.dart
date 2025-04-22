import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/core/url/url.dart';
import 'package:my_desktop_app/features/employee/data/models/response/employee_response.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';

abstract class EmployeeRemoteDataSource {
  Future<EmployeeEntities> addEmployee(Map<String, dynamic> prams);
  Future<List<EmployeeEntities>> getEmployees([Map<String, dynamic>? prams]);
  Future<EmployeeEntities> employeeStatusChange(Map<String, dynamic> prams);
  Future<EmployeeEntities> updateEmployee(Map<String, dynamic> params);
  Future<bool> deleteEmployee(Map<String, dynamic> params);
  Future<bool> allowPictureForProcessing(Map<String, dynamic> params);
  Future<EmployeeEntities> employeeRoleChange(Map<String, dynamic> params);
  Future<EmployeeEntities> wholeDataUpdate(Map<String, dynamic> params);
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
  Future<EmployeeEntities> employeeStatusChange(
      Map<String, dynamic> prams) async {
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

  @override
  Future<bool> allowPictureForProcessing(Map<String, dynamic> params) async {
    try {
      final response = await _apiServices.patchRequest(
          endPoint: ServerUrl.employeeStatusChangeRoute, body: params);
      if (response.statusCode == 200) {
        
      }
      throw Exception("");
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteEmployee(Map<String, dynamic> params) {
    // TODO: implement deleteEmployee
    throw UnimplementedError();
  }

  @override
  Future<EmployeeEntities> employeeRoleChange(Map<String, dynamic> params) {
    // TODO: implement employeeRoleChange
    throw UnimplementedError();
  }

  @override
  Future<EmployeeEntities> updateEmployee(Map<String, dynamic> params) {
    // TODO: implement updateEmployee
    throw UnimplementedError();
  }

  @override
  Future<EmployeeEntities> wholeDataUpdate(Map<String, dynamic> params) {
    // TODO: implement wholeDataUpdate
    throw UnimplementedError();
  }
}
