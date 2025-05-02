import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/widgets/loading_widget.dart';
import 'package:my_desktop_app/core/widgets/my_button.dart';
import 'package:my_desktop_app/core/widgets/my_dialog_box.dart';
import 'package:my_desktop_app/features/organization/presentation/providers/organization_provider.dart';
import 'package:my_desktop_app/features/task/data/models/request/task_prams.dart';
import 'package:my_desktop_app/features/task/domain/entities/task_entities.dart';
import 'package:my_desktop_app/features/task/presentation/provider/task_provider.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/task_card_widget.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/task_form_widget.dart';

class MyTaskView extends ConsumerStatefulWidget {
  const MyTaskView({super.key});

  @override
  ConsumerState<MyTaskView> createState() => _MyTaskViewState();
}

class _MyTaskViewState extends ConsumerState<MyTaskView> {
  String selectedStatus = 'all';

  @override
  Widget build(BuildContext context) {
    final selectedOrg = ref.read(organizationProvider).selectedOrganization?.id;
    if (selectedOrg == null) {
      return Center(
        child: Text("Please select org first"),
      );
    }
    final taskParams = TaskReadParams(
      organizationId: ref.read(organizationProvider).selectedOrganization!.id,
      status: selectedStatus == 'all' ? null : selectedStatus,
    );
    final response = ref.watch(loadTaskProvider(taskParams));

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: TaskStatus.values.length,
              separatorBuilder: (_, __) => SizedBox(width: 8),
              itemBuilder: (_, index) {
                final value = TaskStatus.values[index].name;
                return FilterChip(
                  label: Text(value.toUpperCase()),
                  selected: selectedStatus == value,
                  onSelected: (_) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                );
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(loadTaskProvider);
                // return Future.value();
              },
              child: response.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Center(child: Text("No tasks found."));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return TaskCard(taskModel: data[index]);
                    },
                  );
                },
                error: (error, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyCustomButton(
                        btnText: 'Refresh',
                        onClick: () => setState(() {}),
                      ),
                      SizedBox(height: 10),
                      Text(error.toString()),
                    ],
                  ),
                ),
                loading: () => Center(child: MyLoadingWidget()),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        spacing: 5,
        mainAxisSize: MainAxisSize.min,
        children: [
          // FloatingActionButton(
          //   heroTag: 'View',
          //   onPressed: () {},
          // ),
          FloatingActionButton(
            heroTag: 'Create',
            onPressed: () => showMyDialog(context, TaskForm()),
            tooltip: 'Create New Task',
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
