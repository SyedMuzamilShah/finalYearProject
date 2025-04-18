import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/features/task/data/datasources/task_datasources.dart';
import 'package:my_desktop_app/features/task/data/models/request/task_managment_parmas.dart';
import 'package:my_desktop_app/features/task/data/repositories/task_management_repo_impl.dart';
import 'package:my_desktop_app/features/task/domain/entities/task_managemanat_entities.dart';
import 'package:my_desktop_app/features/task/domain/usecases/task_management_usecase.dart';

final taskManagementProvider =
    StateNotifierProvider<TaskManagmentNotifier, TaskManagementState>((ref) {
  return TaskManagmentNotifier();
});

class TaskManagmentNotifier extends StateNotifier<TaskManagementState> {
  TaskManagmentNotifier() : super(TaskManagementState());

  final TaskManagementUsecase _useCase = TaskManagementUsecaseImpl(
    repo: TaskManagementRepoImpl(
      dataSources: TaskManagamentDataSourcesImpl(services: ApiServices()),
    ),
  );

  Future<void> taskAssign(TaskAssignParams params) async {
    state = state.copyWith(isLoading: true, error: null);

    final response = await _useCase.taskAssign(params);

    response.fold(
      (err) {
        if (err is ValidationFailure){
          print("Testing");
          print(err.errors);
        }
        state = state.copyWith(isLoading: false, error: err.message);
      },
      (succ) {
        state = state.copyWith(
          isLoading: false,
          data: succ,
          error: null,
        );
      },
    );
  }

  Future taskDeassign(TaskDeAssignParams params) async {
    final response = await _useCase.taskDeassign(params);
    response.fold((err) => err, (succ) => succ);
  }

  Future taskVerifie(TaskVerifiedParams params) async {
    final response = await _useCase.taskVerified(params);
    response.fold((err){
      if (err is ValidationFailure){
        print(err.errors);
      }
    }, (succ){
      print(succ);
    });
  }

  Future taskStatusChange(TaskStatusChangeParams params) async {
    final response = await _useCase.taskStatusChange(params);
    response.fold((err) => err, (succ){
      print(succ.assignments.first.status);
    });
  }
}


class TaskManagementState {
  final bool isLoading;
  final String? error;
  final TaskManagementEntities? data;
  final List<Map<String, String>>? validationErrors;

  TaskManagementState({
    this.isLoading = false,
    this.error,
    this.data,
    this.validationErrors,
  });

  TaskManagementState copyWith({
    bool? isLoading,
    String? error,
    TaskManagementEntities? data,
    List<Map<String, String>>? validationErrors,
  }) {
    return TaskManagementState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      data: data ?? this.data,
      validationErrors: validationErrors,
    );
  }
}
