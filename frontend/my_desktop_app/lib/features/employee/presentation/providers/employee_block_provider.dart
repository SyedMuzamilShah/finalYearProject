import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';

final employeeBlockedProvider = FutureProvider<List<EmployeeEntities>>((ref) async {
  return [];
});