import 'package:my_desktop_app/features/overview/domain/entities/employee_statistics_entitties.dart';

class TaskStatisticsModel extends TaskStatisticsEntities {
  TaskStatisticsModel({required super.month, required super.taskNo, required super.monthNumber});

  factory TaskStatisticsModel.fromJson (json) {
    print("Testing....");
    print(json);
    return TaskStatisticsModel(
      month: json['month'],
      taskNo: json['count'] as int,
      monthNumber : json['monthNumber'] as int
    );
  }
}


