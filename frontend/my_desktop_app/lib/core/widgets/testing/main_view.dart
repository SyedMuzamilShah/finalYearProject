// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_desktop_app/features/dashboard/presentation/views/dashboard_view.dart';
// import 'package:my_desktop_app/features/employee/presentation/views/employee_view.dart';
// import 'package:my_desktop_app/testing/pages/attendence_view.dart';
// import 'package:my_desktop_app/testing/pages/settings_view.dart';
// import 'package:my_desktop_app/testing/pages/task_view.dart';
// import 'package:my_desktop_app/testing/sidebar_view.dart';
// import 'package:my_desktop_app/testing/top_bar_view.dart';
// import 'package:sidebarx/sidebarx.dart';

// final sideBarXControllerProvider = StateProvider(
//     (ref) => SidebarXController(selectedIndex: 0, extended: true));

// class SidebarState {
//   final double scale;
//   final double marginTop;
//   final double borderRadius;

//   SidebarState({
//     required this.scale,
//     required this.marginTop,
//     required this.borderRadius,
//   });
// }

// final ValueNotifier<SidebarState> sidebarState = ValueNotifier(
//   SidebarState(scale: 1.0, marginTop: 0.0, borderRadius: 0.0),
// );

// final ValueNotifier mainContentWidget =
//     ValueNotifier<Widget>(MyDashboradView());

// class MyTestingApp extends ConsumerWidget {
//   const MyTestingApp({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final controller = ref.watch(sideBarXControllerProvider);

//     controller.addListener(() {
//       switch (controller.selectedIndex) {
//         case 0:
//           mainContentWidget.value = MyDashboradView();
//         case 1:
//           mainContentWidget.value = MyEmployeeView();
//         case 2:
//           mainContentWidget.value = MyAttendenceView();
//         case 3:
//           mainContentWidget.value = MyTaskView();
//         case 4:
//           mainContentWidget.value = MySettingView();
//       }

//       sidebarState.value = controller.extended
//           ? SidebarState(scale: 1.0, marginTop: 0.0, borderRadius: 0.0)
//           : SidebarState(scale: 0.99, marginTop: 12.0, borderRadius: 8.0);
//     });
//     bool isMobile = MediaQuery.of(context).size.width <= 800;

//     return Scaffold(
//       appBar: isMobile ? AppBar() : null,
//       drawer: ExampleSidebarX(controller: controller),
//       body: Row(
//         children: [
//           if (!isMobile) ExampleSidebarX(controller: controller),
//           Expanded(
//             child: Column(
//               children: [

//                 // Top Bar
//                 if (!isMobile)
//                   ValueListenableBuilder<SidebarState>(
//                     valueListenable: sidebarState,
//                     builder: (context, state, child) {
//                       return AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                           transform: Matrix4.identity()..scale(state.scale),
//                           margin: EdgeInsets.only(top: state.marginTop),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.cyan,
//                             borderRadius: BorderRadius.vertical(
//                               top: Radius.circular(state.borderRadius),
//                             ),
//                           ),
//                           child: MyTopBarWidget());
//                     },
//                   ),
//                 Expanded(
//                   child: ValueListenableBuilder<SidebarState>(
//                     valueListenable: sidebarState,
//                     builder: (context, state, child) {
//                       return AnimatedContainer(
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                           transform: Matrix4.identity()..scale(state.scale),
//                           margin: EdgeInsets.only(bottom: state.marginTop),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: Colors.black87,
//                             borderRadius: BorderRadius.vertical(
//                               bottom: Radius.circular(state.borderRadius),
//                             ),
//                           ),
//                           child: ValueListenableBuilder(
//                               valueListenable: mainContentWidget,
//                               builder: (context, state, child) {
//                                 return state;
//                               }));
//                     },
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
