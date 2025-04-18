// import 'package:flutter/material.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:my_desktop_app/core/theme/sidebarX_theme.dart';
// import 'package:sidebarx/sidebarx.dart';

// class ExampleSidebarX extends StatelessWidget {
//   const ExampleSidebarX({
//     super.key,
//     required SidebarXController controller,
//   }) : _controller = controller;

//   final SidebarXController _controller;

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> data = [
//       {'label': 'Overview', 'icon': Icons.dashboard},
//       {'label': 'Employee', 'icon': Icons.people},
//       {'label': 'Attendance', 'icon': Icons.calendar_today},
//       {'label': 'Task', 'icon': Icons.task},
//       {'label': 'Settings', 'icon': Icons.settings},
//     ];

//     return SidebarX(
//         controller: _controller,
//         theme: mySidebarXTheme,
//         extendedTheme: mySidebarXExtendedTheme,
//         headerBuilder: (context, extended) {
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: ClipRRect(
//                 borderRadius: BorderRadius.circular(50),
//                 child: Image.network(
//                   'https://www.hubspot.com/hubfs/parts-url_1.webp',
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 )),
//           );
//         },
//         items: data.mapWithIndex((element, index) {
//           return SidebarXItem(
//             icon: element['icon'],
//             label: element['label'],
//             onTap: () {
//               debugPrint(element['label']);
//             },
//           );
//         }).toList());
//   }
// }
