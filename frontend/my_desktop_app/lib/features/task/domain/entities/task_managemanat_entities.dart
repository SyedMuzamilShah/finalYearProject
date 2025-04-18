import 'package:my_desktop_app/features/task/data/models/response/task_management_response.dart';


enum TaskCurrentStatus {
  assigned,
  inProgress,
  completed,
  verified,
  rejected,
}

abstract class TaskManagementEntities {
  final List<TaskAssignmentModel> assignments;
  final List<String> alreadyAssigned;

  TaskManagementEntities({
    required this.assignments,
    required this.alreadyAssigned,
  });
}