import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/overview/data/datasources/statistics_datasources.dart';
import 'package:my_desktop_app/features/overview/data/models/request/employee_role_statistics.dart';
import 'package:my_desktop_app/features/overview/data/models/request/task_statistics.dart';
import 'package:my_desktop_app/features/overview/domain/entities/employee_statistics_entitties.dart';
import 'package:my_desktop_app/features/overview/domain/repositories/statistics_repo.dart';

class StatisticsRepoImpl extends StatisticsRepo {
  StatisticsRemoteDataSource dataSource;

  StatisticsRepoImpl(this.dataSource);

  @override
  Future<Either<Failure, EmployeeRoleStatisticsWrapper>>
      getEmployeeRoleStatistics(EmployeeRoleStatisticsParams params) async {
    try {
      var response = await dataSource.employeeRoleStatistics(params.toJson());
      return Right(response);
    } catch (err) {
      return Left(Failure(message: err.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskStatisticsEntities>>> getTaskStatistics(
      TaskStatisticsParams params) async {
    try {
      var response = await dataSource.taskStatistics(params.toJson());
      
      return Right(response);
    } catch (err) {
      return Left(Failure(message: err.toString()));
    }
  }
}
