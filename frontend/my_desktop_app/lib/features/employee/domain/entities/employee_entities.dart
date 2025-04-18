import 'package:my_desktop_app/features/employee/domain/entities/employee_filter_enum_entities.dart';

class EmployeeEntities {
  final String id;
  final String organizationId;
  final String name;
  final String email;
  final String? phone;
  final EmployeeStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? role;

  EmployeeEntities({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.email,
    this.phone,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.role, 
  });
}