import 'package:flutter/material.dart';
import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';

class EmployeeDetialShow extends StatelessWidget {
  final EmployeeEntities employee;
  const EmployeeDetialShow({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(employee.name),
    );
  }
}