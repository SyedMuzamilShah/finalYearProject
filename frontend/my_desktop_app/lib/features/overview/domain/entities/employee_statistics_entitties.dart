import 'package:my_desktop_app/features/employee/domain/entities/employee_filter_enum_entities.dart';

class EmployeeRoleStatisticsEntities {
  final EmployeeRole role;
  final int count;
  final int percentage;
  const EmployeeRoleStatisticsEntities(
      {required this.role, required this.count, required this.percentage});
}


class EmployeeRoleStatisticsWrapper {
  final List<EmployeeRoleStatisticsEntities> roles;
  final int totalEmployees;
  
  const EmployeeRoleStatisticsWrapper({
    required this.roles,
    required this.totalEmployees,
  });
}




class TaskStatisticsEntities {
  final String month;
  final int taskNo;
  final int monthNumber;
  TaskStatisticsEntities({required this.month, required this.taskNo, required this.monthNumber,});
}
