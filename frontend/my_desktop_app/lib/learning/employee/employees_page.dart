// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_desktop_app/learning/employee/employee_card.dart';
// import 'package:my_desktop_app/learning/employee/employee_filter_type.dart';
// import 'package:my_desktop_app/learning/employee/employee_provider.dart';
// import 'package:my_desktop_app/learning/employee/employee_search_bar.dart';
// import 'package:my_desktop_app/learning/employee/filter_chips.dart';

// class EmployeesPage extends ConsumerWidget {
//   const EmployeesPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(employeeProvider);
//     final notifier = ref.read(employeeProvider.notifier);

//     // useEffect(() {
//     //   notifier.fetchEmployees();
//     //   return null;
//     // }, []);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Employee Management'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () => notifier.fetchEmployees(),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const EmployeeFilterChips(),
//             const SizedBox(height: 16),
//             const EmployeeSearchBar(),
//             const SizedBox(height: 16),
//             if (state.isLoading)
//               const Center(child: CircularProgressIndicator()),
//             if (state.error != null)
//               Text(
//                 state.error!,
//                 style: TextStyle(color: Theme.of(context).colorScheme.error),
//               ),
//             if (!state.isLoading && state.error == null)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: state.filteredEmployees.length,
//                   itemBuilder: (context, index) {
//                     final employee = state.filteredEmployees[index];
//                     return EmployeeCard(
//                       employee: employee,
//                       showActions: state.currentFilter == EmployeeFilterType.pending,
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to add employee page
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }