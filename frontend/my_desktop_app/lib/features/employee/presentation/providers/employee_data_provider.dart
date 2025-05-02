// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';

// final employeeDataProvider = FutureProvider<List<EmployeeEntities>>((ref) async {
//   return [];
// });


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
import 'package:my_desktop_app/features/employee/presentation/providers/employee_provider.dart';

final loadEmployeeProvider = FutureProvider.family.autoDispose((ref, EmployeeReadParams prams) async {
  final employeeNotifier = ref.watch(employeeProvider.notifier); // 👈
  return await employeeNotifier.getAllEmployees(prams);
});
