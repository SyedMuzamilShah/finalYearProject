import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_desktop_app/deepseek/employee.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  Color _primaryColor = Colors.indigo;
  final List<Color> _colorOptions = [
    Colors.indigo,
    Colors.teal,
    Colors.deepPurple,
    Colors.blueGrey,
    Colors.pink,
  ];

  final List<Widget> _contentOptions = [
    OverviewContent(),
    // AddUserDataPage(),
    PayrollPage(),
  ];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar
          _buildSidebar(),
          // Main Content
          Expanded(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: _contentOptions[_selectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 33, 33, 33),
            Colors.black87,
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const DrawerHeader(
            child: Text(
              'StaffX',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildSidebarItem(
            icon: Icons.dashboard,
            label: 'Overview',
            index: 0,
          ),
          _buildSidebarItem(
            icon: Icons.people,
            label: 'Employee',
            index: 1,
            hasChildren: true,
            children: [
              _buildSidebarChildItem(
                label: 'Add User',
                index: 1,
              ),
              _buildSidebarChildItem(
                label: 'View User',
                index: 2,
              ),
            ],
          ),
          _buildSidebarItem(
            icon: Icons.calendar_today,
            label: 'Attendance',
            index: 3,
          ),
          _buildSidebarItem(
            icon: Icons.task,
            label: 'Task',
            index: 4,
          ),
          _buildSidebarItem(
            icon: Icons.settings,
            label: 'Settings',
            index: 5,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Theme Color',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _colorOptions.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _primaryColor = _colorOptions[index];
                          });
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _colorOptions[index],
                            shape: BoxShape.circle,
                            border: _primaryColor == _colorOptions[index]
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required int index,
    bool hasChildren = false,
    List<Widget> children = const [],
  }) {
    final bool isSelected = _selectedIndex == index;
    
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: isSelected
              ? BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _primaryColor.withValues(alpha: 0.8),
                      _primaryColor.withValues(alpha: 0.4),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                )
              : null,
          child: ListTile(
            leading: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
            ),
            title: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: hasChildren
                ? Icon(
                    Icons.arrow_drop_down,
                    color: isSelected ? Colors.white : Colors.white70,
                  )
                : null,
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        if (isSelected && hasChildren) ...children,
      ],
    );
  }

  Widget _buildSidebarChildItem({
    required String label,
    required int index,
  }) {
    final bool isSelected = _selectedIndex == index;
    
    return Container(
      margin: const EdgeInsets.only(left: 32, right: 16, bottom: 4),
      decoration: isSelected
          ? BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _primaryColor.withValues(alpha: 0.6),
                  _primaryColor.withValues(alpha: 0.3),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8),
            )
          : null,
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        contentPadding: const EdgeInsets.only(left: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

Widget _buildAppBar() {
  return Container(
    height: 70,
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      children: [
        Text.rich(
          TextSpan(
            text: "Hello!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87
            ),
          children: [
            TextSpan(
            text: "SCARLETTE 😊",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14
            ),
            )
          ] 
          )    
        ),
        const Spacer(),
        // SizedBox(
        //   width: 300,
        //   child: TextField(
        //     decoration: InputDecoration(
        //       hintText: 'Search...',
        //       prefixIcon: const Icon(Icons.search, size: 20),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(30),
        //         borderSide: BorderSide.none,
        //       ),
        //       filled: true,
        //       fillColor: Colors.grey[100],
        //       contentPadding: const EdgeInsets.symmetric(vertical: 8),
        //     ),
        //   ),
        // ),
        const SizedBox(width: 20),
        IconButton(
          icon: const Icon(Icons.notifications),
          color: Colors.grey[600],
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.message),
          color: Colors.grey[600],
          onPressed: () {},
        ),
        const SizedBox(width: 10),
        const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://www.hubspot.com/hubfs/parts-url_1.webp'),
        ),
      ],
    ),
  );
}
}



// Widget _buildDrawer () {
//   return Drawer(
//     child: ,
//   );
// }


class OverviewContent extends StatefulWidget {
  const OverviewContent({super.key});

  @override
  State<OverviewContent> createState() => _OverviewContentState();
}

class _OverviewContentState extends State<OverviewContent> {
  String selectedMapLocation = 'USA';
  String selectedTableStatus = 'Completed';
  String selectedFilter = 'Today';

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;
    final primaryColor = (context.findAncestorStateOfType<DashboardScreenState>()?._primaryColor) ?? Colors.indigo;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning! I live here for sure applications. It\'s a lot of work that today! So it\'s got started.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 24),
          
          // Map Section
          _buildCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _buildDropdown(
                      value: selectedMapLocation,
                      items: const ['USA', 'Canada', 'Mexico'],
                      onChanged: (value) {
                        setState(() {
                          selectedMapLocation = value!;
                        });
                      },
                    ),
                    const Spacer(),
                    _buildDropdown(
                      value: selectedFilter,
                      items: const ['Today', '1 Week', '1 Month'],
                      onChanged: (value) {
                        setState(() {
                          selectedFilter = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SfMaps(
                          layers: [
                            MapTileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              initialFocalLatLng:
                                  const MapLatLng(30.183270, 66.996452),
                              initialZoomLevel: 15,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: 10,
                        child: FloatingActionButton.small(
                          backgroundColor: primaryColor,
                          onPressed: () {},
                          child: const Icon(Icons.fullscreen, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Charts Row
          isMobile
              ? Column(
                  children: [
                    _buildCard(
                      child: _buildLineChart(primaryColor),
                    ),
                    const SizedBox(height: 16),
                    _buildCard(
                      child: _buildPieChart(primaryColor),
                    ),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: _buildCard(
                        child: _buildLineChart(primaryColor),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: _buildCard(
                        child: _buildPieChart(primaryColor),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 24),
          
          // Employee Status Table
          _buildCard(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Employee Status',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                _buildEmployeeTable(primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: value,
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down),
        style: const TextStyle(color: Colors.black87),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLineChart(Color primaryColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Team Performance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(fontSize: 12),
            ),
            primaryYAxis: NumericAxis(
              labelStyle: const TextStyle(fontSize: 12),
            ),
            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                dataSource: [
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40),
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                color: primaryColor,
                width: 3,
                markerSettings: const MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                  borderWidth: 2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPieChart(Color primaryColor) {
    return Column(
      children: [
        Text(
          'Job Distribution',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: SfCircularChart(
            palette: [
              primaryColor,
              primaryColor.withValues(alpha: 0.7),
              primaryColor.withValues(alpha: 0.5),
              primaryColor.withValues(alpha: 0.3),
            ],
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: [
                  ChartData('Completed', 15),
                  ChartData('Pending', 25),
                  ChartData('Reject', 25),
                  ChartData('Absent', 35),
                ],
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                ),
                explode: true,
                explodeIndex: 0,
                explodeOffset: '10%',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeTable(Color primaryColor) {
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
              label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
              label: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
              label: Text('Job Role', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
              label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
              label: Text('TL', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(
              label: Text('View', style: TextStyle(fontWeight: FontWeight.bold)),
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
              color: status == 'Active!' 
                  ? Colors.green[50]
                  : Colors.orange[50],
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
                color: status == 'Active!' 
                    ? Colors.green[800]
                    : Colors.orange[800],
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
}

class SalesData {
  final String year;
  final double sales;

  SalesData(this.year, this.sales);
}

class ChartData {
  final String x;
  final double y;

  ChartData(this.x, this.y);
}