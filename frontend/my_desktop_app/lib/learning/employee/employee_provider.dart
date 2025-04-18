// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_desktop_app/learning/employee/employee_filter_type.dart';
// import 'package:my_desktop_app/learning/employee/employee_model.dart';

// final employeeProvider = StateNotifierProvider<EmployeeNotifier, EmployeeState>((ref) {
//   final repository = ref.watch(employeeRepositoryProvider);
//   return EmployeeNotifier(repository);
// });

// class EmployeeNotifier extends StateNotifier<EmployeeState> {
//   final EmployeeRepository _repository;

//   EmployeeNotifier(this._repository) : super(EmployeeState.initial());

//   Future<void> fetchEmployees({EmployeeFilterType filter = EmployeeFilterType.all}) async {
//     state = state.copyWith(isLoading: true);
//     try {
//       final employees = await _repository.getEmployees(filter: filter);
//       state = state.copyWith(
//         employees: employees,
//         filteredEmployees: employees,
//         isLoading: false,
//         error: null,
//       );
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         error: e.toString(),
//       );
//     }
//   }

//   Future<void> searchEmployees(String query) async {
//     if (query.isEmpty) {
//       state = state.copyWith(filteredEmployees: state.employees);
//       return;
//     }

//     final filtered = state.employees.where((employee) {
//       return employee.name.toLowerCase().contains(query.toLowerCase()) ||
//           employee.email.toLowerCase().contains(query.toLowerCase());
//     }).toList();

//     state = state.copyWith(filteredEmployees: filtered);
//   }

//   Future<void> updateEmployeeStatus(String employeeId, String status) async {
//     try {
//       await _repository.updateEmployeeStatus(employeeId, status);
//       final updatedEmployees = state.employees.map((employee) {
//         if (employee.id == employeeId) {
//           return employee.copyWith(status: status);
//         }
//         return employee;
//       }).toList();

//       state = state.copyWith(employees: updatedEmployees);
//     } catch (e) {
//       // Handle error
//     }
//   }

//   // Add more methods as needed
// }

// class EmployeeState {
//   final List<Employee> employees;
//   final List<Employee> filteredEmployees;
//   final bool isLoading;
//   final String? error;
//   final EmployeeFilterType currentFilter;

//   EmployeeState({
//     required this.employees,
//     required this.filteredEmployees,
//     required this.isLoading,
//     this.error,
//     required this.currentFilter,
//   });

//   factory EmployeeState.initial() => EmployeeState(
//         employees: [],
//         filteredEmployees: [],
//         isLoading: false,
//         currentFilter: EmployeeFilterType.all,
//       );

//   EmployeeState copyWith({
//     List<Employee>? employees,
//     List<Employee>? filteredEmployees,
//     bool? isLoading,
//     String? error,
//     EmployeeFilterType? currentFilter,
//   }) {
//     return EmployeeState(
//       employees: employees ?? this.employees,
//       filteredEmployees: filteredEmployees ?? this.filteredEmployees,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//       currentFilter: currentFilter ?? this.currentFilter,
//     );
//   }
// }