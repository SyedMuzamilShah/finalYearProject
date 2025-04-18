import 'package:my_desktop_app/features/task/domain/entities/task_managemanat_entities.dart';

class TaskAssignParams {
  final String taskId;
  final List employeesId;

  TaskAssignParams({required this.taskId, required this.employeesId});
  
  Map<String, dynamic> toJson() {
    return {
      'taskId' : taskId,
      'employeesId':employeesId
    };
  }
}

// _id ObjectId (PK)
// taskId ObjectId (ref: Task, required)
// employeeId ObjectId (ref: Employee, required)
// assignedBy ObjectId (ref: Admin, required)
// status enum ["Assigned", "InProgress", "Completed", "Verified", "Rejected"] (default: "Assigned")
// deadline DateTime
// createdAt DateTime


class TaskDeAssignParams {
  Map<String, dynamic> toJson() {
    return {};
  }
}

class TaskVerifiedParams {
  final String taskId;
  final List<String> employeesId;

  TaskVerifiedParams({
    required this.taskId,
    required this.employeesId,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'employeesId': employeesId,
    };
  }
}

class TaskStatusChangeParams {
  final String taskId;
  final TaskCurrentStatus status;
  final List<dynamic> employeesId;

  TaskStatusChangeParams({
    required this.taskId,
    required this.status,
    required this.employeesId,
  });

  Map<String, dynamic> toJson() {
    return {
      'taskId': taskId,
      'status': status.name,
      'employeesId': employeesId,
    };
  }
}
