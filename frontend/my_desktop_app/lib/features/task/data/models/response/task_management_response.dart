import 'package:my_desktop_app/features/task/domain/entities/task_managemanat_entities.dart';

class TaskAssignmentModel {
  final String id;
  final String taskId;
  final String employeeId;
  final String assignedBy;
  final String status;
  final DateTime deadline;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskAssignmentModel({
    required this.id,
    required this.taskId,
    required this.employeeId,
    required this.assignedBy,
    required this.status,
    required this.deadline,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TaskAssignmentModel.fromJson(Map<String, dynamic> json) {
    return TaskAssignmentModel(
      id: json['_id'],
      taskId: json['taskId'],
      employeeId: json['employeeId'],
      assignedBy: json['assignedBy'],
      status: json['status'],
      deadline: DateTime.parse(json['deadline']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}




class TaskManagementResponseModel extends TaskManagementEntities {
  TaskManagementResponseModel({required super.assignments, required super.alreadyAssigned});

  factory TaskManagementResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskManagementResponseModel(
      assignments: (json['assignments'] as List)
          .map((e) => TaskAssignmentModel.fromJson(e))
          .toList(),
      alreadyAssigned: (json['alreadyAssigned'] != null) ? List<String>.from(json['alreadyAssigned']) : [],
    );
  }
}
