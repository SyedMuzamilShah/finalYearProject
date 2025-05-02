import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:my_desktop_app/core/widgets/date_select_widget.dart';
import 'package:my_desktop_app/features/task/data/models/request/task_prams.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  late TaskCreateParams createParams;
  int _currentStep = 0;
  final _formKey = GlobalObjectKey<FormState>(1);
  
  // Task data model
  final Map<String, dynamic> _taskData = {
    'title': '',
    'description': '',
    'dueDate': null,
    'pdfFiles': [],
    'location': {
      'type': 'Point',
      'coordinates': [0.0, 0.0],
      'address': '',
    },
    'aroundDistanceMeter': 1000,
    'assignedEmployees': [],
    'organizationId': '680b90783e89bdee9eb7e458',
    'status': 'CREATED',
  };

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController(text: '1000');
  final TextEditingController _employeeSearchController = TextEditingController();

  List<Map<String, dynamic>> _allEmployees = [];
  List<Map<String, dynamic>> _filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    // Mock employee data - replace with API call
    _allEmployees = [
      {'id': '1', 'name': 'John Doe', 'position': 'Field Agent', 'selected': false},
      {'id': '2', 'name': 'Jane Smith', 'position': 'Supervisor', 'selected': false},
      {'id': '3', 'name': 'Robert Johnson', 'position': 'Technician', 'selected': false},
      {'id': '4', 'name': 'Sarah Williams', 'position': 'Inspector', 'selected': false},
      {'id': '5', 'name': 'Michael Brown', 'position': 'Manager', 'selected': false},
    ];
    _filteredEmployees = List.from(_allEmployees);

    createParams = TaskCreateParams(title: "", organizationId: "", description: "", dueDate: DateTime.now());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _radiusController.dispose();
    _employeeSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Task'),
      ),
      body: Column(
        children: [
          // Horizontal Stepper Header
          SizedBox(
            height: 80,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.blue),
              ),
              child: Stepper(
                currentStep: _currentStep,
                type: StepperType.horizontal,
                controlsBuilder: (context, details) => const SizedBox.shrink(),
                steps: [
                  Step(
                    title: const Text('Basic'),
                    content: const SizedBox(),
                    isActive: _currentStep >= 0,
                    state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Location'),
                    content: const SizedBox(),
                    isActive: _currentStep >= 1,
                    state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Assign'),
                    content: const SizedBox(),
                    isActive: _currentStep >= 2,
                    state: _currentStep > 2 ? StepState.complete : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Review'),
                    content: const SizedBox(),
                    isActive: _currentStep >= 3,
                    // state: StepState.indexed,
                    state: _currentStep > 3 ? StepState.complete : StepState.indexed,
                  ),
                  Step(
                    title: const Text('final'),
                    content: const SizedBox(),
                    isActive: _currentStep >= 4,
                    state: StepState.indexed,
                  ),
                ],
              ),
            ),
          ),

          // Stepper Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: IndexedStack(
                index: _currentStep,
                children: [
                  // Step 1: Basic Information
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _titleController,
                          decoration: const InputDecoration(
                            labelText: 'Task Title*',
                            hintText: 'Enter task title',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title';
                            }
                            return null;
                          },
                          // onChanged: (value) => _taskData['title'] = value,
                          onChanged: (value) => createParams.copyWith(title: value),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter task description',
                            alignLabelWithHint: true,
                          ),
                          maxLines: 3,
                          onChanged: (value) => _taskData['description'] = value,
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          // onTap: () => _selectDueDate(context),
                          onTap: () async{
                            DateTime? time = await selectDueDate(context);
                            if (time != null){
                              setState(() {
                              _taskData['dueDate'] = time;
                              createParams.copyWith(dueDate: time);
                              });
                            }
                          },
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Due Date*',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 14),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _taskData['dueDate'] == null
                                      ? 'Select due date'
                                      : DateFormat('MMM dd, yyyy - hh:mm a')
                                          .format(_taskData['dueDate']),
                                ),
                                const Icon(Icons.calendar_today, size: 20),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // PDF Upload Section
                        const Text(
                          'Attach PDF Files (Optional)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ..._taskData['pdfFiles'].map<Widget>((file) {
                              return Chip(
                                label: Text(file['name']),
                                deleteIcon: const Icon(Icons.close, size: 18),
                                onDeleted: () => _removePdf(file),
                              );
                            }).toList(),
                            ActionChip(
                              avatar: const Icon(Icons.attach_file, size: 18),
                              label: const Text('Add PDF'),
                              onPressed: _pickPdfFiles,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Step 2: Location Information
                  Column(
                    children: [
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address*',
                          hintText: 'Enter task location address',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an address';
                          }
                          return null;
                        },
                        onChanged: (value) => _taskData['location']['address'] = value,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: '0.0',
                              decoration: const InputDecoration(
                                labelText: 'Longitude',
                                prefixText: ' ',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _taskData['location']['coordinates'][0] = 
                                      double.tryParse(value) ?? 0.0;
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              initialValue: '0.0',
                              decoration: const InputDecoration(
                                labelText: 'Latitude',
                                prefixText: ' ',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  _taskData['location']['coordinates'][1] = 
                                      double.tryParse(value) ?? 0.0;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _radiusController,
                        decoration: const InputDecoration(
                          labelText: 'Radius (meters)*',
                          hintText: 'Allowed distance from location',
                          suffixText: 'meters',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a radius';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _taskData['aroundDistanceMeter'] = int.tryParse(value) ?? 1000;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.map, size: 48, color: Colors.grey),
                              const SizedBox(height: 8),
                              Text(
                                _addressController.text.isEmpty
                                    ? 'Location preview'
                                    : _addressController.text,
                                textAlign: TextAlign.center,
                              ),
                              if (_taskData['location']['coordinates'][0] != 0.0 || 
                                  _taskData['location']['coordinates'][1] != 0.0)
                                Text(
                                  'Coordinates: ${_taskData['location']['coordinates'][0]}, '
                                  '${_taskData['location']['coordinates'][1]}',
                                  style: const TextStyle(fontSize: 12),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Step 3: Assign to Employees
                  Column(
                    children: [
                      TextFormField(
                        controller: _employeeSearchController,
                        decoration: const InputDecoration(
                          labelText: 'Search Employees',
                          hintText: 'Type to search employees',
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: _filterEmployees,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Select Employees to Assign',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      ..._filteredEmployees.map((employee) {
                        return CheckboxListTile(
                          title: Text(employee['name']),
                          subtitle: Text(employee['position']),
                          value: employee['selected'],
                          onChanged: (value) {
                            setState(() {
                              employee['selected'] = value;
                              if (value == true) {
                                _taskData['assignedEmployees'].add({
                                  'id': employee['id'],
                                  'name': employee['name']
                                });
                              } else {
                                _taskData['assignedEmployees'].removeWhere(
                                  (e) => e['id'] == employee['id']);
                              }
                            });
                          },
                          secondary: const CircleAvatar(child: Icon(Icons.person)),
                        );
                      }),
                    ],
                  ),

                  // Step 4: Summary
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryItem('Title', _taskData['title']),
                      _buildSummaryItem('Description', _taskData['description']),
                      _buildSummaryItem(
                        'Due Date', 
                        _taskData['dueDate'] == null 
                            ? 'Not set' 
                            : DateFormat('MMM dd, yyyy - hh:mm a')
                                .format(_taskData['dueDate']),
                      ),
                      if (_taskData['pdfFiles'].isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Text(
                          'Attached Files',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        ..._taskData['pdfFiles'].map<Widget>((file) {
                          return _buildSummaryItem('PDF', file['name']);
                        }).toList(),
                      ],
                      const SizedBox(height: 16),
                      const Text(
                        'Location Details',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      _buildSummaryItem('Address', _taskData['location']['address']),
                      _buildSummaryItem(
                        'Coordinates', 
                        '${_taskData['location']['coordinates'][0]}, '
                        '${_taskData['location']['coordinates'][1]}'),
                      _buildSummaryItem(
                        'Radius', 
                        '${_taskData['aroundDistanceMeter']} meters'),
                      const SizedBox(height: 16),
                      const Text(
                        'Assigned Employees',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (_taskData['assignedEmployees'].isEmpty)
                        _buildSummaryItem('None', 'No employees assigned'),
                      ..._taskData['assignedEmployees'].map<Widget>((emp) {
                        return _buildSummaryItem(emp['name'], emp['position'] ?? '');
                      }).toList(),
                    ],
                  ),
                
                  // Step 5: Success
                  Text("Successfully created")
                ],
              ),
            ),
          ),

          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  OutlinedButton(
                    onPressed: _cancel,
                    child: const Text('Back'),
                  ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _continue,
                  child: Text(_currentStep == 3 ? 'Submit Task' : 'Continue'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Future<void> _pickPdfFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _taskData['pdfFiles'].addAll(result.files.map((file) {
            return {'name': file.name, 'path': file.path};
          }).toList());
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking files: $e')),
      );
    }
  }

  void _removePdf(Map<String, dynamic> file) {
    setState(() {
      _taskData['pdfFiles'].removeWhere((f) => f['name'] == file['name']);
    });
  }

  void _filterEmployees(String query) {
    setState(() {
      _filteredEmployees = _allEmployees.where((employee) {
        return employee['name'].toLowerCase().contains(query.toLowerCase()) ||
               employee['position'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void _continue() {
    if (_currentStep == 0) {
      if (!_formKey.currentState!.validate()) return;
      if (_taskData['dueDate'] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a due date')),
        );
        return;
      }
    } else if (_currentStep == 1) {
      if (_taskData['location']['address'].isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter an address')),
        );
        return;
      }
    }

    if (_currentStep < 3) {
      setState(() => _currentStep += 1);
    } else {
      _submitTask();
    }
  }

  void _cancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep -= 1);
    }
  }

  void _submitTask() {
    // Here you would send the task to your backend
    print('Submitting task: $_taskData');
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task created successfully!')),
    );

    // In a real app, you might navigate away or reset the form
    // Navigator.pop(context);
  }
}

// import 'package:flutter/material.dart';
// import 'package:my_desktop_app/core/widgets/date_select_widget.dart';
// import 'create_task_state.dart';
// import 'steps/basic_information_form.dart';
// import 'steps/location_information_form.dart';
// import 'steps/assign_employees_form.dart';
// import 'steps/review_task_form.dart';

// class CreateTaskScreen extends StatefulWidget {
//   const CreateTaskScreen({super.key});

//   @override
//   State<CreateTaskScreen> createState() => _CreateTaskScreenState();
// }

// class _CreateTaskScreenState extends State<CreateTaskScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final CreateTaskState _taskState = CreateTaskState();
//   int _currentStep = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Create New Task')),
//       body: Column(
//         children: [
//           _buildStepper(),
//           Expanded(child: _buildStepContent()),
//         ],
//       ),
//     );
//   }

//   Widget _buildStepper() {
//     return SizedBox(
//       height: 80,
//       child: Stepper(
//         currentStep: _currentStep,
//         type: StepperType.horizontal,
//         controlsBuilder: (context, details) => const SizedBox.shrink(),
//         onStepTapped: (index) {
//           setState(() {
//             _currentStep = index;
//           });
//         },
//         steps: [
//           Step(title: const Text('Basic'), content: const SizedBox(), isActive: _currentStep >= 0),
//           Step(title: const Text('Location'), content: const SizedBox(), isActive: _currentStep >= 1),
//           Step(title: const Text('Assign'), content: const SizedBox(), isActive: _currentStep >= 2),
//           Step(title: const Text('Review'), content: const SizedBox(), isActive: _currentStep >= 3),
//           Step(title: const Text('Final'), content: const SizedBox(), isActive: _currentStep >= 4),
//         ],
//       ),
//     );
//   }

//   Widget _buildStepContent() {
//     switch (_currentStep) {
//       case 0:
//         return BasicInformationForm(formKey: _formKey, taskState: _taskState);
//       case 1:
//         return LocationInformationForm(taskState: _taskState);
//       case 2:
//         return AssignEmployeesForm(taskState: _taskState);
//       case 3:
//         return ReviewTaskForm(taskState: _taskState);
//       default:
//         return const Center(child: Text('Finish Step'));
//     }
//   }
// }
