import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/provider/theme_provider.dart';

class MySettingView extends ConsumerWidget {
  const MySettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // User Profile Settings
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            onTap: () {
              // Navigate to Edit Profile screen
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Change Password'),
            onTap: () {
              // Navigate to Change Password screen
            },
          ),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Two-Factor Authentication'),
            trailing: Switch(
              value: true, // Example value
              onChanged: (value) {
                // Toggle 2FA
              },
            ),
          ),
          Divider(),

          // Notification Settings
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notification Settings'),
            onTap: () {
              // Navigate to Notification Settings screen
            },
          ),
          Divider(),

          // Theme and Appearance
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Theme and Appearance'),
            onTap: () {
              // Navigate to Theme Settings screen
            },
          ),
          Divider(),

          ListTile(
            leading: Icon(Icons.security),
            title: Text('Dark mode'),
            trailing: Switch(
              inactiveTrackColor: Theme.of(context).secondaryHeaderColor,
              activeColor: Theme.of(context).primaryColor,
              
              value:
                  ref.watch(themeProvider) == ThemeMode.dark, // Example value
              onChanged: (value) {
                if (ref.watch(themeProvider) == ThemeMode.dark){
                  ref.watch(themeProvider.notifier).state = ThemeMode.light;
                }else{
                  ref.watch(themeProvider.notifier).state = ThemeMode.dark;
                }
              },
            ),
          ),
          Divider(),
          // Language and Region
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Language and Region'),
            onTap: () {
              // Navigate to Language Settings screen
            },
          ),
          Divider(),

          // Privacy and Security
          ListTile(
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy and Security'),
            onTap: () {
              // Navigate to Privacy Settings screen
            },
          ),
          Divider(),

          // Help and Support
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help and Support'),
            onTap: () {
              // Navigate to Help Center
            },
          ),
        ],
      ),
    );
  }
}
