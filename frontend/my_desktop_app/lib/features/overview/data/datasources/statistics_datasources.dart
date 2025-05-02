import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/core/url/url.dart';
import 'package:my_desktop_app/features/overview/data/models/response/employee_role_statistics_model.dart';
import 'package:my_desktop_app/features/overview/data/models/response/task_statistics_model.dart';
import 'package:my_desktop_app/features/overview/domain/entities/employee_statistics_entitties.dart';

abstract class StatisticsRemoteDataSource {
  Future<EmployeeRoleStatisticsWrapper> employeeRoleStatistics(
      Map<String, dynamic> prams);
  Future<List<TaskStatisticsEntities>> taskStatistics(
      Map<String, dynamic> prams);
}

class StatisticsRemoteDataSourceImpl extends StatisticsRemoteDataSource {
  final ApiServices _apiServices;
  StatisticsRemoteDataSourceImpl({required ApiServices apiServices})
      : _apiServices = apiServices;
  @override
  Future<EmployeeRoleStatisticsWrapper> employeeRoleStatistics(
      Map<String, dynamic> prams) async {
    try {
      final response = await _apiServices.getRequest(
        endPoint: ServerUrl.employeeRoleStatistics,
        queryParameters: prams,
      );
      if (response.statusCode == 200) {
        var data = response.data['data'];
        return EmployeeRoleStatisticsWrapperModel.fromJson(data);
      }

      throw Exception("");
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<List<TaskStatisticsEntities>> taskStatistics(
      Map<String, dynamic> prams) async {
    try {
      final response = await _apiServices.getRequest(
        endPoint: ServerUrl.taskStatistics,
        queryParameters: prams,
      );
      if (response.statusCode == 200) {
        final data = response.data['data']['monthlyStats'] as List;

        final List<TaskStatisticsEntities> createdData = data
            .map((d) => TaskStatisticsModel.fromJson(d as Map<String, dynamic>))
            .toList();
            
        return createdData;
      }

      throw Exception("");
    } catch (err) {
      rethrow;
    }
  }
}
