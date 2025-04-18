import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:my_desktop_app/core/widgets/loading_widget.dart';
import 'package:my_desktop_app/core/widgets/my_dialog_box.dart';
import 'package:my_desktop_app/core/widgets/my_text_field.dart';
import 'package:my_desktop_app/features/organization/presentation/providers/organization_provider.dart';
import 'package:my_desktop_app/features/task/data/models/request/task_prams.dart';
import 'package:my_desktop_app/features/task/presentation/provider/task_provider.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/search_employee_assign_widget.dart';
import 'package:my_desktop_app/features/task/presentation/widgets/task_model.dart';

class TaskForm extends StatefulWidget {
  final TaskLocation? initialLocation;
  const TaskForm({
    super.key,
    this.initialLocation,
  });

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();

  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  TaskPriority _priority = TaskPriority.medium;
  // String? _assigneeId;
  TaskLocation? _location;

  @override
  void initState() {
    super.initState();
    _location = widget.initialLocation;
    if (_location?.address != null) {
      _addressController.text = _location!.address!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Consumer(builder: (context, ref, _) {
          final orgState = ref.watch(organizationProvider).selectedOrganization;
          final organizationId =
              orgState?.organizationId ?? 'No organization selected';
          final taskState = ref.watch(taskProvider);
          final taskNotifier = ref.watch(taskProvider.notifier);

          final fieldErrors = {
            for (var e in taskState.errorList ?? []) e['path']: e['msg']
          };

          if (orgState?.organizationId == null) {
            return Center(
              child: Text("Please selete organization first"),
            );
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Add New Employee',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (taskState.isLoading) const Center(child: MyLoadingWidget()),
              if (taskState.errorMessage != null)
                _buildErrorBox(taskState.errorMessage!, colorScheme),
              MyCustomTextField(
                controller: _titleController,
                labelText: "Title",
                hintText: "Enter your title",
                errorText: fieldErrors['title'],
                prefixIcon: Icons.title,
                validatorFuncation: (value) =>
                    (value?.isEmpty ?? true) ? 'Required' : null,
              ),
              MyCustomTextField(
                controller: _descriptionController,
                labelText: "Description",
                hintText: "Enter your description",
                errorText: fieldErrors['description'],
                prefixIcon: Icons.description,
                maxLines: 4,
                validatorFuncation: (value) =>
                    (value?.isEmpty ?? true) ? 'Required' : null,
              ),
              _buildDatePicker(),
              _buildPrioritySelector(),
              _buildLocationSection(context),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    _submitForm(taskNotifier, taskState, organizationId, ref),
                child: const Text('Create Task'),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildErrorBox(String message, ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: colorScheme.error.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          message,
          style: TextStyle(
            color: colorScheme.error,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _submitForm(TaskNotifier notifier, TaskState state,
      String organizationId, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      final taskParams = TaskCreateParams(
        title: _titleController.text,
        organizationId: organizationId,
        description: _descriptionController.text,
        dueDate: _dueDate,
        location: LocationModel(
          latitude: _location!.latitude,
          longitude: _location!.longitude,
        ),
      );

      bool response = await notifier.create(model: taskParams);

      if (response && context.mounted) {
        Navigator.pop(context);

        // ✅ Watch the latest taskProvider value after state is updated
        final currentTask = ref.read(taskProvider).currentTask;

        if (currentTask != null) {
          showMyDialog(
              context, SearchEmployeeAssignWidget(currentTask: currentTask));
        } else {
          showMyDialog(
              context, const Center(child: Text("Something went wrong")));
        }
      }
    }
  }

  Widget _buildDatePicker() {
    return ListTile(
      title: const Text('Due Date'),
      subtitle: Text(DateFormat('MMM dd, yyyy').format(_dueDate)),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: _dueDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (pickedDate != null) {
          setState(() => _dueDate = pickedDate);
        }
      },
    );
  }

  Widget _buildPrioritySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Priority'),
        Row(
          children: TaskPriority.values.map((priority) {
            return Expanded(
              child: RadioListTile<TaskPriority>(
                title: Text(priority.name.toUpperCase()),
                value: priority,
                groupValue: _priority,
                onChanged: (value) => setState(() => _priority = value!),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: MyCustomTextField(
                controller: _addressController,
                labelText: 'Address',
                hintText: 'Enter address or tap map',
                onChanged: (value) {
                  if (_location != null) {
                    _location = TaskLocation(
                      latitude: _location!.latitude,
                      longitude: _location!.longitude,
                      address: value,
                    );
                  }
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.map),
              onPressed: () => _showMapPicker(context),
            ),
          ],
        ),
        if (_location != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const Icon(Icons.location_pin, size: 16, color: Colors.red),
                const SizedBox(width: 4),
                Text(
                  'Lat: ${_location!.latitude.toStringAsFixed(4)}, '
                  'Lng: ${_location!.longitude.toStringAsFixed(4)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _showMapPicker(BuildContext context) {
    LatLng? selectedLocation = _location?.toLatLng();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Location'),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: FlutterMap(
              options: MapOptions(
                initialCenter:
                    selectedLocation ?? const LatLng(30.1834, 66.9987),
                initialZoom: 12.0,
                onTap: (_, latLng) {
                  selectedLocation = latLng;
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.task_manager',
                ),
                if (selectedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: selectedLocation!,
                        width: 40,
                        height: 40,
                        child: const Icon(Icons.location_pin,
                            color: Colors.red, size: 40),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (selectedLocation != null) {
                  setState(() {
                    _location = TaskLocation(
                      latitude: selectedLocation!.latitude,
                      longitude: selectedLocation!.longitude,
                      address: _addressController.text.isNotEmpty
                          ? _addressController.text
                          : null,
                    );
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Select'),
            ),
          ],
        );
      },
    );
  }
}
