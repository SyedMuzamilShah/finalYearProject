import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/overview/data/models/request/employee_role_statistics.dart';
import 'package:my_desktop_app/features/overview/data/models/request/task_statistics.dart';
import 'package:my_desktop_app/features/overview/domain/entities/employee_statistics_entitties.dart';

abstract class StatisticsRepo {
      Future<Either<Failure, EmployeeRoleStatisticsWrapper>> getEmployeeRoleStatistics(EmployeeRoleStatisticsParams params);
      Future<Either<Failure, List<TaskStatisticsEntities>>> getTaskStatistics(TaskStatisticsParams params);
}