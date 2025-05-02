// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:my_desktop_app/core/provider/main_content_provider.dart';
// import 'package:my_desktop_app/core/provider/route_provider.dart';
// import 'package:my_desktop_app/core/widgets/loading_widget.dart';
// import 'package:my_desktop_app/core/widgets/my_dialog_box.dart';
// import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
// import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';
// import 'package:my_desktop_app/features/employee/domain/entities/employee_filter_enum_entities.dart';
// import 'package:my_desktop_app/features/employee/presentation/providers/employee_data_provider.dart';
// import 'package:my_desktop_app/features/employee/presentation/providers/employee_provider.dart';
// import 'package:my_desktop_app/features/employee/presentation/views/employee_detail_view.dart';
// import 'package:my_desktop_app/features/employee/presentation/widgets/employee_add_card.dart';
// import 'package:my_desktop_app/features/employee/presentation/widgets/employee_card_widget.dart';
// import 'package:my_desktop_app/features/employee/presentation/widgets/employee_error_widget.dart';
// import 'package:my_desktop_app/features/employee/presentation/widgets/employee_search_field_widget.dart';
// import 'package:my_desktop_app/features/employee/presentation/widgets/employee_state_widget.dart';
// import 'package:my_desktop_app/features/organization/presentation/providers/organization_provider.dart';

// class MyEmployeeView extends ConsumerStatefulWidget {
//   const MyEmployeeView({super.key});

//   @override
//   ConsumerState<MyEmployeeView> createState() => _MyEmployeeViewState();
// }

// class _MyEmployeeViewState extends ConsumerState<MyEmployeeView>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController _searchController = TextEditingController();
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;

//   EmployeeReadParams _employeeParams = EmployeeReadParams();

//   EmployeeStatus _selectedFilter = EmployeeStatus.all;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//     _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeInOut,
//       ),
//     );
//     _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeOutBack,
//       ),
//     );
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged(String value) {
//     setState(() {
//       _employeeParams = _employeeParams.copyWith(searchQuery: value);
//     });
//   }

//   void _onFilterChanged(EmployeeStatus status) {
//     setState(() {
//       _selectedFilter = status;
//       _employeeParams = _employeeParams.copyWith(status: status.name);
//     });
//   }

//   Future<void> _refreshData() async {
//     final selectedOrg = ref.watch(organizationProvider).selectedOrganization;
//     if (selectedOrg != null) {
//       ref.invalidate(loadEmployeeProvider);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: ScaleTransition(
//           scale: _scaleAnimation,
//           child: Column(
//             children: [
//               // Animated filter chips
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: SizedBox(
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
//                 ),
//               ),

//               // Search bar with animation
//               SlideTransition(
//                 position: Tween<Offset>(
//                   begin: const Offset(0, -0.9),
//                   end: Offset.zero,
//                 ).animate(CurvedAnimation(
//                   parent: _animationController,
//                   curve: Curves.easeOut,
//                 )),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: EmployeeSearchBar(
//                     controller: _searchController,
//                     onChanged: _onSearchChanged,
//                     initialParams: _employeeParams,
//                     onAdvancedSearch: (value) {
//                       print("Advanced search");
//                     },
//                   ),
//                 ),
//               ),

//               // Employee list
//               Expanded(
//                 child: _buildEmployeeList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: ScaleTransition(
//         scale: _scaleAnimation,
//         child: FloatingActionButton(
//           onPressed: () => showMyDialog(context, const EmployeeAddWidget()),
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmployeeList() {

//     // Check the organization is selected
//     final selectedOrg = ref.watch(organizationProvider).selectedOrganization;

//     // if the organization is selected so picked the organizationId
//     final params = selectedOrg != null
//         ? _employeeParams.copyWith(organizationId: selectedOrg.organizationId)
//         : null;

//     // If organization is not selected then show the message and return;
//     if (selectedOrg == null) {
//       return const Center(child: Text("Please select organization first"));
//     }

//     // load the employee
//     final employee = ref.watch(loadEmployeeProvider(params));

//     //
//     return RefreshIndicator(

//       // the function which hit the server
//       onRefresh: _refreshData,
//       child: employee.when(
//         loading: () => const Center(child: MyLoadingWidget()),
//         error: (error, stack) => EmployeeErrorWidget(
//           error: error,
//           onRetry: _refreshData,
//         ),
//         data: (data) {
//           if (data.isEmpty) {
//             // if the data is empty then this widget is show
//             return EmptyStateWidget(
//               message: 'No ${_selectedFilter.name} employees found',
//               onRefresh: _refreshData,
//             );
//           }

//           // if the employee is got then pass them  into another widget
//           // Pass the employee List,
//           // pass the selected status
//           return AnimatedListWidget(
//             items: data,
//             selectedFilter: _selectedFilter,
//           );
//         },
//       ),
//     );
//   }
// }

// class AnimatedFilterChip extends StatelessWidget {
//   final String label;
//   final bool selected;
//   final VoidCallback onSelected;
//   final int animationDelay;

//   const AnimatedFilterChip({
//     super.key,
//     required this.label,
//     required this.selected,
//     required this.onSelected,
//     this.animationDelay = 0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 200 + animationDelay),
//       curve: Curves.easeInOut,
//       margin: EdgeInsets.only(left: animationDelay == 0 ? 16 : 0),
//       child: FilterChip(
//         label: Text(label),
//         selected: selected,
//         onSelected: (_) => onSelected(),
//         backgroundColor:
//             selected ? _getColorForStatus(label, context) : Colors.grey[200],
//         labelStyle: TextStyle(
//           color: selected ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }

//   Color _getColorForStatus(String status, context) {
//     switch (status.toLowerCase()) {
//       case 'verified':
//         return Colors.green;
//       case 'pending':
//         return Colors.orange;
//       case 'blocked':
//         return Colors.red;
//       default:
//         return Theme.of(context).primaryColor;
//     }
//   }
// }

// class AnimatedListWidget extends StatelessWidget {
//   final List<EmployeeEntities> items;
//   final EmployeeStatus
//       selectedFilter; // this mean that top status filter value can be pass

//   const AnimatedListWidget({
//     super.key,
//     required this.items,
//     required this.selectedFilter,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16),
//       itemCount: items.length,
//       itemBuilder: (context, index) {
//         print("Testing the value : $selectedFilter");
//         print(selectedFilter == EmployeeStatus.pending);
        
//         // return AnimatedEmployeeCard(
//         //   key: ValueKey(items[index].id),
//         //   employee: items[index],
//         //   index: index,
//         //   showApproveButton: selectedFilter == EmployeeStatus.pending,
//         //   showUnblockButton: selectedFilter == EmployeeStatus.blocked,
//         // );
//         return EmployeeCard(employee: items[index],);
//       },
//     );
//   }
// }

// class AnimatedEmployeeCard extends ConsumerWidget {
//   final EmployeeEntities employee;
//   final int index;
//   final bool showApproveButton;
//   final bool showUnblockButton;

//   const AnimatedEmployeeCard({
//     super.key,
//     required this.employee,
//     required this.index,
//     this.showApproveButton = false,
//     this.showUnblockButton = false,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final animationDelay = index * 100;

//     return TweenAnimationBuilder(
//       tween: Tween<double>(begin: 0, end: 1),
//       duration: Duration(milliseconds: 300 + animationDelay),
//       curve: Curves.easeInOut,
//       builder: (context, value, child) {
//         return Opacity(
//           opacity: value,
//           child: Transform.translate(
//             offset: Offset(0, (1 - value) * 20),
//             child: child,
//           ),
//         );
//       },
//       child: InkWell(
//         onTap: () {
//           ref.read(breadcrumbProvider.notifier).state = BreadcrumbItem(
//               route: Row(
//             children: [
//               InkWell(
//                   onTap: () {
//                     print("Testing successfully");
//                     mainContentWidget.value = MyEmployeeView();
//                     ref.read(breadcrumbProvider.notifier).state =
//                         BreadcrumbItem(
//                             route: Text('Employee'),);
                    
//                   },
//                   child: Text('employee /')),
//               Text(employee.name),
//             ],
//           ));
//           mainContentWidget.value = EmployeeDetialShow(employee: employee);
//           // ref.watch(mainContentProvider.notifier).state = EmployeeDetialShow(employee: employee);
//           // mainContentProvider.notifier = EmployeeDetialShow(employee: employee);
//           // Navigator.push(context, MaterialPageRoute(builder: (_)=> EmployeeDetialShow(employee: employee)));
//         },
//         child: EmployeeCard(
//           employee: employee,
//           onStatusChanged: () async {
//             if (EmployeeStatus.pending.name == employee.status.name) {
//               EmployeeUpdateParams params = EmployeeUpdateParams(
//                   id: employee.id, status: EmployeeStatus.verified.name);
//               await ref.read(employeeProvider.notifier).updateEmployee(params);
//             }
//             print("current status is : ${employee.status.name}");
//           },
//         ),
//       ),
//     );
//   }
// }
