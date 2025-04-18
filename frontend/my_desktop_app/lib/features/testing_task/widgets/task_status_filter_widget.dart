// import 'package:flutter/material.dart';
// import 'package:my_desktop_app/features/task/presentation/widgets/task_model.dart';

// class TaskStatusFilterWidget extends StatelessWidget {
//   const TaskStatusFilterWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Row(
//           children: [
//             const SizedBox(width: 8),
//             FilterChip(
//               label: const Text('All'),
//               selected: _filterStatus == null,
//               onSelected: (_) => _filterTasks(null),
//             ),
//             ...TaskStatus.values.map((status) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                 child: FilterChip(
//                   label: Text(status.name.toUpperCase()),
//                   selected: _filterStatus == status,
//                   onSelected: (_) => _filterTasks(status),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }