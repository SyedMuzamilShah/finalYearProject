// import 'package:flutter/material.dart';
// import 'package:my_desktop_app/features/employee/domain/entities/employee_filter_enum_entities.dart';

// class EmployeeTopStatusFilterBar extends StatelessWidget {
//   const EmployeeTopStatusFilterBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//                   height: 50,
//                   child: ListView.separated(
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemCount: EmployeeStatus.values.length,
//                     separatorBuilder: (_, __) => const SizedBox(width: 8),
//                     itemBuilder: (_, index) {
//                       final status = EmployeeStatus.values[index];
//                       return AnimatedFilterChip(
//                         label: status.name.toUpperCase(),
//                         selected: _selectedFilter == status,
//                         onSelected: () => _onFilterChanged(status),
//                         animationDelay: index * 100,
//                       );
//                     },
//                   ),
//                 );
//   }
// }