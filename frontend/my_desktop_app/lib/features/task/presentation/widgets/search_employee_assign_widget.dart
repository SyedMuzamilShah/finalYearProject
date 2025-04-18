import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/widgets/loading_widget.dart';
import 'package:my_desktop_app/core/widgets/my_button.dart';
import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
import 'package:my_desktop_app/features/employee/presentation/providers/employee_data_provider.dart';
import 'package:my_desktop_app/features/task/data/models/request/task_managment_parmas.dart';
import 'package:my_desktop_app/features/task/domain/entities/task_entities.dart';
import 'package:my_desktop_app/features/task/presentation/provider/task_managment_provider.dart';

class SearchEmployeeAssignWidget extends ConsumerStatefulWidget {
  final TaskEntities currentTask;
  const SearchEmployeeAssignWidget({super.key, required this.currentTask});

  @override
  ConsumerState<SearchEmployeeAssignWidget> createState() =>
      _SearchEmployeeAssignWidgetState();
}

class _SearchEmployeeAssignWidgetState
    extends ConsumerState<SearchEmployeeAssignWidget> {
  final TextEditingController _controller = TextEditingController();
  List<String> assignUserIds = [];
  EmployeeReadParams _params = const EmployeeReadParams();

  void _onAssignPressed() async {
    final notifier = ref.read(taskManagementProvider.notifier);
    final params = TaskAssignParams(
      taskId: widget.currentTask.id,
      employeesId: assignUserIds,
    );

    await notifier.taskAssign(params);

    final state = ref.read(taskManagementProvider);
    if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${state.error}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Employees assigned successfully.")),
      );
      Navigator.pop(context); // Optionally close the dialog after assignment
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeeResponse = ref.watch(loadEmployeeProvider(_params));
    final taskState = ref.watch(taskManagementProvider);

    return Column(
      children: [
        EmployeeSearchBar(
          controller: _controller,
          onChanged: (value) {
            setState(() {
              _params = _params.copyWith(searchQuery: value);
            });
          },
          initialParams: _params,
          onAdvancedSearch: (value) {
            setState(() {
              _params = value;
            });
          },
        ),
        const SizedBox(height: 12),
        Expanded(
          child: employeeResponse.when(
            loading: () => const Center(child: MyLoadingWidget()),
            error: (err, _) => Center(child: Text('Error: $err')),
            data: (employees) {
              if (employees.isEmpty) {
                return const Center(child: Text('No employees found.'));
              }

              return ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  final isSelected = assignUserIds.contains(employee.id);

                  return ListTile(
                    title: Text(employee.name),
                    subtitle: Text(employee.email),
                    trailing: IconButton(
                      icon: Icon(
                        isSelected ? Icons.remove_circle : Icons.assignment_add,
                        color: isSelected ? Colors.red : Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          isSelected
                              ? assignUserIds.remove(employee.id)
                              : assignUserIds.add(employee.id);
                        });
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        if (assignUserIds.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyCustomButton(
              btnText: taskState.isLoading ? 'Assigning...' : 'Assign',
              onClick: taskState.isLoading ? null : _onAssignPressed,
            ),
          ),
      ],
    );
  }
}



class EmployeeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final EmployeeReadParams initialParams;
  final ValueChanged<EmployeeReadParams> onAdvancedSearch;

  const EmployeeSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.initialParams,
    required this.onAdvancedSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchField(
            controller: controller,
            onChanged: onChanged,
            // hintText: 'Search employees...',
          ),
        ),
        IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AdvancedEmployeeSearchDialog(
                initialParams: initialParams,
                onApply: onAdvancedSearch,
              ),
            );
          },
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const SearchField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search employees...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.1),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
    );
  }
}

class AdvancedEmployeeSearchDialog extends StatefulWidget {
  final EmployeeReadParams initialParams;
  final ValueChanged<EmployeeReadParams> onApply;

  const AdvancedEmployeeSearchDialog({
    super.key,
    required this.initialParams,
    required this.onApply,
  });

  @override
  State<AdvancedEmployeeSearchDialog> createState() =>
      _AdvancedEmployeeSearchDialogState();
}

class _AdvancedEmployeeSearchDialogState
    extends State<AdvancedEmployeeSearchDialog> {
  late EmployeeReadParams _params;
  final List<String> _roles = ['Admin', 'Manager', 'Employee', 'Staff'];
  final List<String> _statuses = ['Active', 'Pending', 'Blocked'];

  @override
  void initState() {
    super.initState();
    _params = widget.initialParams;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Advanced Search'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _params.role,
              decoration: const InputDecoration(labelText: 'Role'),
              items: _roles.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _params = _params.copyWith(role: value);
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _params.status,
              decoration: const InputDecoration(labelText: 'Status'),
              items: _statuses.map((status) {
                return DropdownMenuItem(
                  value: status.toLowerCase(),
                  child: Text(status),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _params = _params.copyWith(status: value);
                });
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Email Verified'),
              value: _params.isEmailVerified ?? false,
              onChanged: (value) {
                setState(() {
                  _params = _params.copyWith(isEmailVerified: value);
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onApply(_params);
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
