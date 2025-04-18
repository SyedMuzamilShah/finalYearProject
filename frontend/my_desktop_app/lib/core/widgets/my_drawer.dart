import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sidebarx/sidebarx.dart';

final sidebarProvider = StateProvider.autoDispose<int>((ref) => 0);
final sidebarController = StateProvider.autoDispose<SidebarXController>((ref) {
  return SidebarXController(selectedIndex: ref.watch(sidebarProvider));
});

class MyDrawerWidget extends ConsumerWidget {
  const MyDrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Map<String, dynamic>> data = [
      {'label': 'Overview', 'icon': Icons.dashboard},
      {'label': 'Employee', 'icon': Icons.people},
      {'label': 'Attendance', 'icon': Icons.calendar_today},
      {'label': 'Task', 'icon': Icons.task},
      {'label': 'Settings', 'icon': Icons.settings},
    ];

    Color primaryColor = Colors.indigo;
    final List<Color> colorOptions = [
      Colors.indigo,
      Colors.teal,
      Colors.deepPurple,
      Colors.blueGrey,
      Colors.pink,
    ];
    return Scaffold(
        body: Stack(
          children: [
            Drawer(
                  clipBehavior: Clip.none,
                  child: Container(
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
            child: ListView(
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
            
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return _buildSidebarItem(
                      icon: data[index]['icon'] as IconData,
                      label: data[index]['label'] as String,
                      index: index,
                    );
                  },
                ),
            
                // const Spacer(),
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
                          itemCount: colorOptions.length,
                          separatorBuilder: (_, __) => const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: colorOptions[index],
                                  shape: BoxShape.circle,
                                  border: primaryColor == colorOptions[index]
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
                  ),
                ),
          

            Positioned(
              top: 10,
              left: 10,
              child: InkWell(
              onTap: ()=> Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 15,)),
            ),
          
          ],
        ));
  }
}

Widget _buildSidebarItem({
  required IconData icon,
  required String label,
  required int index,
}) {
  final bool isSelected = index == 0;
  Color primaryColor = Colors.indigo;
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: isSelected
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor.withValues(alpha: 0.8),
                    primaryColor.withValues(alpha: 0.4),
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
          onTap: () {
            if (kDebugMode) {
              print(index);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ],
  );
}
