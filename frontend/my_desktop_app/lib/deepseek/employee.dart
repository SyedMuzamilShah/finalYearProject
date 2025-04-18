import 'package:flutter/material.dart';

class PayrollPage extends StatelessWidget {
  const PayrollPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payroll'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 1, // Responsive grid
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio:1.7, // Adjust card aspect ratio
          ),
          itemCount: employees.length,
          itemBuilder: (context, index) {
            final employee = employees[index];
            return EmployeeCard(employee: employee);
          },
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final Map<String, String> employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  employee['name']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    employee['status']!,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: employee['status'] == 'Active' ? Colors.green : Colors.red,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              employee['role']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 16),
            Text(
              employee['email']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            _buildInfoRow(Icons.location_on, employee['location']!),
            _buildInfoRow(Icons.phone, employee['contact']!),
            _buildInfoRow(Icons.cake, employee['birthday']!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}


  // Sample employee data
  final List<Map<String, String>> employees = [
    {
      'name': 'Kadin Levin',
      'status': 'Active',
      'role': 'Sr. UUUX Design',
      'email': 'Kardinlevin@sample.com',
      'location': 'Manchester, USA',
      'contact': '(201) 555-0124',
      'birthday': 'July 24, 1998',
    },
    {
      'name': 'Erin Mango',
      'status': 'Active',
      'role': 'Software Developer',
      'email': 'erinmango4@sample.com',
      'location': 'New York, USA',
      'contact': '(239) 555-0108',
      'birthday': 'Aug 2, 1994',
    },
    {
      'name': 'Corey Schieffer',
      'status': 'Inactive',
      'role': 'Software Developer',
      'email': 'coret6ev@test.com',
      'location': 'Montreal, Canada',
      'contact': '(904) 335-2403',
      'birthday': 'Jan 4, 1999',
    },
    {
      'name': 'Kadin Levin',
      'status': 'Active',
      'role': 'Sr. UUUX Design',
      'email': 'Kardinlevin@sample.com',
      'location': 'Manchester, USA',
      'contact': '(201) 555-0124',
      'birthday': 'July 24, 1998',
    },
    {
      'name': 'Erin Mango',
      'status': 'Active',
      'role': 'Software Developer',
      'email': 'erinmango4@sample.com',
      'location': 'New York, USA',
      'contact': '(239) 555-0108',
      'birthday': 'Aug 2, 1994',
    },
    {
      'name': 'Corey Schieffer',
      'status': 'Inactive',
      'role': 'Software Developer',
      'email': 'coret6ev@test.com',
      'location': 'Montreal, Canada',
      'contact': '(904) 335-2403',
      'birthday': 'Jan 4, 1999',
    },
    {
      'name': 'Kadin Levin',
      'status': 'Active',
      'role': 'Sr. UUUX Design',
      'email': 'Kardinlevin@sample.com',
      'location': 'Manchester, USA',
      'contact': '(201) 555-0124',
      'birthday': 'July 24, 1998',
    },
    {
      'name': 'Erin Mango',
      'status': 'Active',
      'role': 'Software Developer',
      'email': 'erinmango4@sample.com',
      'location': 'New York, USA',
      'contact': '(239) 555-0108',
      'birthday': 'Aug 2, 1994',
    },
    {
      'name': 'Corey Schieffer',
      'status': 'Inactive',
      'role': 'Software Developer',
      'email': 'coret6ev@test.com',
      'location': 'Montreal, Canada',
      'contact': '(904) 335-2403',
      'birthday': 'Jan 4, 1999',
    },
    {
      'name': 'Kadin Levin',
      'status': 'Active',
      'role': 'Sr. UUUX Design',
      'email': 'Kardinlevin@sample.com',
      'location': 'Manchester, USA',
      'contact': '(201) 555-0124',
      'birthday': 'July 24, 1998',
    },
    {
      'name': 'Erin Mango',
      'status': 'Active',
      'role': 'Software Developer',
      'email': 'erinmango4@sample.com',
      'location': 'New York, USA',
      'contact': '(239) 555-0108',
      'birthday': 'Aug 2, 1994',
    },
    {
      'name': 'Corey Schieffer',
      'status': 'Inactive',
      'role': 'Software Developer',
      'email': 'coret6ev@test.com',
      'location': 'Montreal, Canada',
      'contact': '(904) 335-2403',
      'birthday': 'Jan 4, 1999',
    },
    {
      'name': 'Kadin Levin',
      'status': 'Active',
      'role': 'Sr. UUUX Design',
      'email': 'Kardinlevin@sample.com',
      'location': 'Manchester, USA',
      'contact': '(201) 555-0124',
      'birthday': 'July 24, 1998',
    },
    {
      'name': 'Erin Mango',
      'status': 'Active',
      'role': 'Software Developer',
      'email': 'erinmango4@sample.com',
      'location': 'New York, USA',
      'contact': '(239) 555-0108',
      'birthday': 'Aug 2, 1994',
    },
    {
      'name': 'Corey Schieffer',
      'status': 'Inactive',
      'role': 'Software Developer',
      'email': 'coret6ev@test.com',
      'location': 'Montreal, Canada',
      'contact': '(904) 335-2403',
      'birthday': 'Jan 4, 1999',
    },
  ];

