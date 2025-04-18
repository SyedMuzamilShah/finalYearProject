// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_desktop_app/learning/employee/employee_filter_type.dart';
// import 'package:my_desktop_app/learning/employee/employee_provider.dart';

// class EmployeeFilterChips extends ConsumerWidget {
//   const EmployeeFilterChips({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final currentFilter = ref.watch(employeeProvider.select((state) => state.currentFilter));
//     final notifier = ref.read(employeeProvider.notifier);

//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: EmployeeFilterType.values.map((filter) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: FilterChip(
//               label: Text(_getFilterLabel(filter)),
//               selected: currentFilter == filter,
//               onSelected: (selected) {
//                 if (selected) {
//                   notifier.fetchEmployees(filter: filter);
//                 }
//               },
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   String _getFilterLabel(EmployeeFilterType filter) {
//     switch (filter) {
//       case EmployeeFilterType.all:
//         return 'All';
//       case EmployeeFilterType.verified:
//         return 'Verified';
//       case EmployeeFilterType.blocked:
//         return 'Blocked';
//       case EmployeeFilterType.pending:
//         return 'Pending';
//       case EmployeeFilterType.active:
//         return 'Active';
//     }
//   }
// }