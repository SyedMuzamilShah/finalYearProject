import 'package:flutter/material.dart';

class MyTableWidget extends StatelessWidget {
  final Color primaryColor;
  const MyTableWidget({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: DataTable(
          headingRowColor: WidgetStateProperty.resolveWith<Color>(
            (states) => primaryColor.withValues(alpha: 0.1),
          ),
          columns: const [
            DataColumn(
                label:
                    Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Name',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Job Role',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Status',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
                label:
                    Text('TL', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
              label:
                  Text('View', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
          rows: [
            _buildDataRow(
              id: '2563',
              name: 'John Keith',
              role: 'UI/UX Designer',
              status: 'Active!',
              tl: 'Swidden V.',
              primaryColor: primaryColor,
            ),
            _buildDataRow(
              id: '2567',
              name: 'Anita Donvert',
              role: 'React Developer',
              status: 'Active!',
              tl: 'Kada C.',
              primaryColor: primaryColor,
            ),
            _buildDataRow(
              id: '2571',
              name: 'Michael Brown',
              role: 'Flutter Developer',
              status: 'On Leave',
              tl: 'Swidden V.',
              primaryColor: primaryColor,
            ),
            _buildDataRow(
              id: '2575',
              name: 'Sarah Johnson',
              role: 'Product Manager',
              status: 'Active!',
              tl: 'Kada C.',
              primaryColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

DataRow _buildDataRow({
  required String id,
  required String name,
  required String role,
  required String status,
  required String tl,
  required Color primaryColor,
}) {
  return DataRow(
    cells: [
      DataCell(Text(id)),
      DataCell(Text(name)),
      DataCell(Text(role)),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: status == 'Active!' ? Colors.green[50] : Colors.orange[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: status == 'Active!'
                  ? Colors.green[100]!
                  : Colors.orange[100]!,
            ),
          ),
          child: Text(
            status,
            style: TextStyle(
              color:
                  status == 'Active!' ? Colors.green[800] : Colors.orange[800],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataCell(Text(tl)),
      DataCell(
        IconButton(
          icon: Icon(Icons.message, color: primaryColor),
          onPressed: () {},
        ),
      ),
    ],
  );
}
