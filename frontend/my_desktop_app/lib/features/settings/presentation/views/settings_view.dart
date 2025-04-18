import 'package:flutter/material.dart';

class MySettingView extends StatefulWidget {
  const MySettingView({super.key});

  @override
  State<MySettingView> createState() => _MySettingViewState();
}

class _MySettingViewState extends State<MySettingView> {
  @override
  Widget build(BuildContext context) {
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