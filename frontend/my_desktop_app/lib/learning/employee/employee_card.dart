// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_desktop_app/learning/employee/employee_model.dart';
// import 'package:my_desktop_app/learning/employee/employee_provider.dart';

// class EmployeeCard extends ConsumerWidget {
//   final Employee employee;
//   final bool showActions;

//   const EmployeeCard({
//     super.key,
//     required this.employee,
//     this.showActions = true,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final notifier = ref.read(employeeProvider.notifier);
//     final theme = Theme.of(context);

//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 30,
//                   backgroundImage: employee.profileImageUrl != null
//                       ? NetworkImage(employee.profileImageUrl!)
//                       : const AssetImage('assets/default_avatar.png') as ImageProvider,
//                 ),
//                 const SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         employee.name,
//                         style: theme.textTheme.titleMedium,
//                       ),
//                       Text(employee.email),
//                       Text(employee.role),
//                     ],
//                   ),
//                 ),
//                 if (employee.status == 'pending')
//                   const Chip(
//                     label: Text('Pending'),
//                     backgroundColor: Colors.orange,
//                   ),
//               ],
//             ),
//             if (showActions) ...[
//               const Divider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   if (employee.status == 'pending')
//                     _buildActionButton(
//                       context,
//                       'Accept',
//                       Colors.green,
//                       () => notifier.updateEmployeeStatus(employee.id, 'active'),
//                     ),
//                   if (employee.status == 'pending')
//                     const SizedBox(width: 8),
//                   if (employee.status == 'pending')
//                     _buildActionButton(
//                       context,
//                       'Reject',
//                       Colors.red,
//                       () => notifier.updateEmployeeStatus(employee.id, 'rejected'),
//                     ),
//                   if (employee.status != 'pending')
//                     IconButton(
//                       icon: const Icon(Icons.edit),
//                       onPressed: () => _showEditDialog(context, employee),
//                     ),
//                   if (employee.status != 'blocked')
//                     IconButton(
//                       icon: const Icon(Icons.block),
//                       onPressed: () => notifier.updateEmployeeStatus(employee.id, 'blocked'),
//                     ),
//                   if (employee.status == 'blocked')
//                     IconButton(
//                       icon: const Icon(Icons.lock_open),
//                       onPressed: () => notifier.updateEmployeeStatus(employee.id, 'active'),
//                     ),
//                   IconButton(
//                     icon: const Icon(Icons.visibility),
//                     onPressed: () => _showProfileDialog(context, employee),
//                   ),
//                   if (!employee.isVerified)
//                     IconButton(
//                       icon: const Icon(Icons.verified_user),
//                       onPressed: () => _requestVerification(context, employee),
//                     ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButton(
//       BuildContext context, String text, Color color, VoidCallback onPressed) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//       ),
//       onPressed: onPressed,
//       child: Text(text),
//     );
//   }

//   void _showProfileDialog(BuildContext context, Employee employee) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(employee.name),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CircleAvatar(
//               radius: 50,
//               backgroundImage: employee.profileImageUrl != null
//                   ? NetworkImage(employee.profileImageUrl!)
//                   : const AssetImage('assets/default_avatar.png') as ImageProvider,
//             ),
//             const SizedBox(height: 16),
//             Text('Email: ${employee.email}'),
//             Text('Role: ${employee.role}'),
//             Text('Status: ${employee.status}'),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _requestVerification(BuildContext context, Employee employee) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Request Verification'),
//         content: const Text('Request this employee to upload a proper profile picture for face recognition?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               // Implement verification request logic
//               Navigator.pop(context);
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Verification request sent')),
//               );
//             },
//             child: const Text('Request'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showEditDialog(BuildContext context, Employee employee) {
//     // Implement edit dialog
//   }
// }