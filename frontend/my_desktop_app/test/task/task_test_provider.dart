import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_desktop_app/core/services/local_database_service.dart';
import 'package:my_desktop_app/core/services/token_service.dart';
import 'package:my_desktop_app/features/task/data/models/request/task_managment_parmas.dart';
import 'package:my_desktop_app/features/task/data/models/request/task_prams.dart';
import 'package:my_desktop_app/features/task/domain/entities/task_managemanat_entities.dart';
import 'package:my_desktop_app/features/task/presentation/provider/task_managment_provider.dart';
import 'package:my_desktop_app/features/task/presentation/provider/task_provider.dart';

import '../login_for_token_testing.dart';


void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.initFlutter();
  // await LocalDatabaseService().init();
  // LoginForTokenSaving().login();
  // return;
  TokenService().initialize();
  TaskNotifier notifier = TaskNotifier();

  // TaskReadParams params = TaskReadParams(page: 1, limit: 10,);

  // await notifier.read(params.copyWith());
  // print(notifier.state.errorMessage);
  TaskManagmentNotifier taskManagmentNotifier = TaskManagmentNotifier();

  // TaskAssignParams params = TaskAssignParams(
  //   taskId: '68005de3f1d85ea552f72b88',
  //   employeesId: ['67f4dc41d93ef0194c7ca365'],
  // );
  // await taskManagmentNotifier.taskAssign(params);
  // print(taskManagmentNotifier.state.error);

  // TaskVerifiedParams verifiedParams = TaskVerifiedParams(
  //   taskId: '68005de3f1d85ea552f72b88',
  //   employeesId: ['67f4dc41d93ef0194c7ca365'],
  // );
  // taskManagmentNotifier.taskVerifie(verifiedParams);

  TaskStatusChangeParams changeParams = TaskStatusChangeParams(
    taskId: '68005de3f1d85ea552f72b88',
    status: TaskCurrentStatus.assigned,
    employeesId: ['67f4dc41d93ef0194c7ca365'],
  );
  await taskManagmentNotifier.taskStatusChange(changeParams);


  // final model = TaskCreateParams(title: "hello world", organizationId: '67fcc0d13f8d82e5463cd23d', description: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2Y0", dueDate: DateTime.utc(2025, 6, 6), location: LocationModel(latitude: 23.52356, longitude: 32.6431, address: 'quetta'));

  // final response = await notifier.create(model: model);
  // print(response);
  // print(notifier.state.task);
  // print(notifier.state.errorList);
}