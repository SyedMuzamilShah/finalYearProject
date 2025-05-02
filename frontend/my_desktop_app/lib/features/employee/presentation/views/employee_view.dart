import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/widgets/my_dialog_box.dart';
import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_filter_enum_entities.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_add_card.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_list_view.dart';
import 'package:my_desktop_app/features/employee/presentation/widgets/employee_search_field_widget.dart';

class MyEmployeeView extends ConsumerStatefulWidget {
  const MyEmployeeView({super.key});

  @override
  ConsumerState<MyEmployeeView> createState() => _MyEmployeeViewState();
}

class _MyEmployeeViewState extends ConsumerState<MyEmployeeView> {
  late TextEditingController _searchController;

  EmployeeReadParams _employeeParams = EmployeeReadParams();

  EmployeeStatus _selectedFilter = EmployeeStatus.all;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Animated filter chips
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            child: SizedBox(
              height: 50,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: EmployeeStatus.values.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, index) {
                  final status = EmployeeStatus.values[index];
                  final String label = status.name.toUpperCase();
                  final bool isSelected = _selectedFilter == status;
                  return FilterChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) => {
                      setState(() {
                        _selectedFilter = status;
                        _employeeParams =
                            _employeeParams.copyWith(status: status.name);
                      })
                    },
                    backgroundColor: isSelected
                        ? _getColorForStatus(label, context)
                        : Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  );
                },
              ),
            ),
          ),

          // Search bar with animation
          EmployeeSearchBar(
            controller: _searchController,
            onChanged: _onSearchChanged,
            initialParams: _employeeParams,
            onAdvancedSearch: (value) {
              print("Advanced search");
            },
          ),

          // Employee list
          Expanded(
            child: EmployeeListView(_employeeParams, _selectedFilter.name),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMyDialog(context, const EmployeeAddWidget()),
        child: const Icon(Icons.add),
      ),
    );
  }

  Color _getColorForStatus(String status, context) {
    switch (status.toLowerCase()) {
      case 'verified':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'blocked':
        return Colors.red;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _employeeParams = _employeeParams.copyWith(searchQuery: value);
    });
  }
}
