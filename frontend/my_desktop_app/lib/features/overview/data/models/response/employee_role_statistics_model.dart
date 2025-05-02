import 'package:my_desktop_app/features/employee/domain/entities/employee_filter_enum_entities.dart';
import 'package:my_desktop_app/features/overview/domain/entities/employee_statistics_entitties.dart';

// employee_role_statistics_model.dart
class EmployeeRoleStatisticsModel extends EmployeeRoleStatisticsEntities {
  const EmployeeRoleStatisticsModel({
    required super.role,
    required super.count,
    required super.percentage,
  });

  factory EmployeeRoleStatisticsModel.fromJson(Map<String, dynamic> json) {
    return EmployeeRoleStatisticsModel(
      role: _parseRole(json['role']),
      count: json['count'] as int,
      percentage: json['percentage'] as int,
    );
  }

  static EmployeeRole _parseRole(String role) {
    switch (role) {
      case 'GUEST': return EmployeeRole.guest;
      case 'SERVANT': return EmployeeRole.servant;
      case 'MANAGER': return EmployeeRole.manager;
      case 'EMPLOYEE': return EmployeeRole.employee;
      default: throw ArgumentError('Unknown role: $role');
    }
  }
}

class EmployeeRoleStatisticsWrapperModel extends EmployeeRoleStatisticsWrapper {
  const EmployeeRoleStatisticsWrapperModel({
    required super.roles,
    required super.totalEmployees,
  });

  factory EmployeeRoleStatisticsWrapperModel.fromJson(Map<String, dynamic> json) {
    return EmployeeRoleStatisticsWrapperModel(
      roles: (json['roles'] as List)
          .map((roleJson) => EmployeeRoleStatisticsModel.fromJson(roleJson))
          .toList(),
      totalEmployees: json['totalEmployees'] as int,
    );
  }
}