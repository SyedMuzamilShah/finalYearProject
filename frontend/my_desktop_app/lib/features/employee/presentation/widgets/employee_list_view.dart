import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/provider/main_content_provider.dart';
import 'package:my_desktop_app/core/provider/route_provider.dart';
import 'package:my_desktop_app/core/widgets/loading_widget.dart';
import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
import 'package:my_desktop_app/features/employee/presentation/providers/employee_data_provider.dart';
import 'package:my_desktop_app/features/employee/presentation/views/employee_detail_view.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_card_widget.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_error_widget.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_route.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_state_widget.dart';
import 'package:my_desktop_app/features/organization/presentation/providers/organization_provider.dart';

class EmployeeListView extends ConsumerWidget {
  final EmployeeReadParams readParams;
  final String filterStatus;
  const EmployeeListView(this.readParams, this.filterStatus, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check the organization is selected
    final selectedOrg = ref.watch(organizationProvider).selectedOrganization;

    // If organization is not selected then show the message and return;
    if (selectedOrg == null) {
      return const Center(child: Text("Please select organization first"));
    }

    // if the organization is selected so picked the organizationId
    final params =
        readParams.copyWith(organizationId: selectedOrg.organizationId);

    // load the employee
    final employee = ref.watch(loadEmployeeProvider(params));

    //
    return RefreshIndicator(
      // the function which hit the server
      onRefresh: () async {
        ref.invalidate(loadEmployeeProvider);
      },
      child: employee.when(
        loading: () => const Center(child: MyLoadingWidget()),
        error: (error, stack) => EmployeeErrorWidget(
          error: error,
          onRetry: () async {
            ref.invalidate(loadEmployeeProvider);
          },
        ),
        data: (data) {
          if (data.isEmpty) {
            // if the data is empty then this widget is show
            return EmptyStateWidget(
              message: 'No $filterStatus employees found',
              onRefresh: () async {
                ref.invalidate(loadEmployeeProvider);
              },
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  ref.read(routeDisplayProvider.notifier).state = RouteDisplayItem(
                    route: EmployeeRoute(name: data[index].name,)
                  );
                  mainContentWidget.value = EmployeeDetialShow(employee: data[index]);
                },
                child: EmployeeCard(
                  readParams: params,
                  onStatusChanged: null,
                  employee: data[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
