import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_filter_enum_entities.dart';

EmployeeStatus _parseStatus(String status) {
  return EmployeeStatus.values.firstWhere(
    (e) => e.name.toUpperCase() == status.toUpperCase(),
    orElse: () => EmployeeStatus.pending,
  );
}

class EmployeeResponseModel extends EmployeeEntities {
  EmployeeResponseModel(
      {required super.id,
      required super.organizationId,
      required super.name,
      required super.email,
      required super.status,
      required super.role,
      required super.createdAt});

  factory EmployeeResponseModel.fromJson(json) {
    print("Inside function : ${json['status']}");
    return EmployeeResponseModel(
      id: json["_id"],
      organizationId: json['organizationId'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      status: _parseStatus(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
