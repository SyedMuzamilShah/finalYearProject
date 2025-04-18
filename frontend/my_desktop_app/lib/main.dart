import 'package:flutter/material.dart';
import 'package:my_desktop_app/core/baseView/base_view.dart';
import 'package:my_desktop_app/core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    ValueNotifier<Widget> valueNotifier = ValueNotifier(Container());
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      
      routes: {
        '/': (context) => const MyHomePage(),
        '/about': (context) => const AboutPage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}

class MyHomePage extends BaseViewClass {
  const MyHomePage({super.key});

  @override
  Widget buildMainContentArea() {
    return Container(
      color: Colors.amber,
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("database $index"),
          );
        },
      ),
    );
  }

  @override
  Widget buildSideBarArea() {
    return _buildDrawer();
  }

  @override
  Widget buildTopBarArea() {
    return _buildTopBar();
  }
}

class AboutPage extends BaseViewClass {
  const AboutPage({super.key});

  @override
  Widget buildMainContentArea() {
    return Center(
      child: Text(
        "This is the About Page",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget buildSideBarArea() {
    return _buildDrawer();
  }

  @override
  Widget buildTopBarArea() {
    return _buildTopBar();
  }
}

class ContactPage extends BaseViewClass {
  const ContactPage({super.key});

  @override
  Widget buildMainContentArea() {
    return Center(
      child: Text(
        "This is the Contact Page",
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget buildSideBarArea() {
    return _buildDrawer();
  }

  @override
  Widget buildTopBarArea() {
    return _buildTopBar();
  }
}

/// Helper functions for Sidebar and TopBar (used in all pages)
Widget _buildDrawer() {
  return Drawer(
    backgroundColor: Colors.red,
    child: Column(
      children: [
        ListTile(
          leading: const CircleAvatar(),
          title: const Text("Home"),
          onTap: () => _navigateTo('/'),
        ),
        ListTile(
          leading: const CircleAvatar(),
          title: const Text("About"),
          onTap: () => _navigateTo('/about'),
        ),
        ListTile(
          leading: const CircleAvatar(),
          title: const Text("Contact"),
          onTap: () => _navigateTo('/contact'),
        ),
      ],
    ),
  );
}

Widget _buildTopBar() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.white,
          width: 200,
          child: const TextField(),
        ),
        const CircleAvatar(),
      ],
    ),
  );
}

/// Navigation Helper
void _navigateTo(String route) {
  BuildContext? context = MyApp.navigatorKey.currentContext;
  if (context != null) {
    Navigator.of(context).pushNamed(route);
  }
}
