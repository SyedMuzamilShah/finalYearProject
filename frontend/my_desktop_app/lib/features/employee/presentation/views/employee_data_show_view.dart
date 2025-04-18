// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EmployeeDataShowView extends ConsumerWidget {
//   const EmployeeDataShowView({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Employee Data'),
//       ),
//       body: Center(
//         child: Text('Employee Data Show View'),
//       ),
//     );
//   }
// }


//   Widget _buildEmployeeList() {
//     final selectedOrg = ref.watch(organizationProvider).selectedOrganization;
//     final params = selectedOrg != null
//         ? _employeeParams.copyWith(organizationId: selectedOrg.organizationId)
//         : null;

//     if (selectedOrg == null) {
//       return const Center(child: Text("Please select organization first"));
//     }

//     final employee = ref.watch(loadEmployeeProvider(params));
//     return RefreshIndicator(
//       onRefresh: _refreshData,
//       child: employee.when(
//         loading: () => const Center(child: MyLoadingWidget()),
//         error: (error, stack) => EmployeeErrorWidget(
//           error: error,
//           onRetry: _refreshData,
//         ),
//         data: (data) {
//           if (data.isEmpty) {
//             return EmptyStateWidget(
//               message: 'No ${_selectedFilter.name} employees found',
//               onRefresh: _refreshData,
//             );
//           }
//           return AnimatedListWidget(
//             items: data,
//             selectedFilter: _selectedFilter,
//           );
//         },
//       ),
//     );
//   }
// }