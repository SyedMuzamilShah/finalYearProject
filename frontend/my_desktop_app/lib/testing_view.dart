import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import 'package:my_desktop_app/core/provider/theme_provider.dart';

// 1. User Profile Model
class UserProfile {
  String name;
  String email;
  String phone;
  String? bio;
  File? profileImage;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    this.bio,
    this.profileImage,
  });
}

// 2. Main Settings Page (Existing)
class MySettingView extends StatefulWidget {
  const MySettingView({super.key});

  @override
  State<MySettingView> createState() => _MySettingViewState();
}

class _MySettingViewState extends State<MySettingView> {
  UserProfile currentUser = UserProfile(
    name: "John Doe",
    email: "john.doe@example.com",
    phone: "+1 234 567 890",
    bio: "Flutter Developer",
  );

  bool twoFactorEnabled = false;
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;
  String currentLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Profile Section
          _buildProfileHeader(),
          const SizedBox(height: 16),

          // User Profile Settings
          _buildSectionTitle('Account Settings'),
          _buildSettingTile(
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () => _navigateToEditProfile(context),
          ),
          _buildSettingTile(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () => _navigateToChangePassword(context),
          ),
          _buildSettingTileWithSwitch(
            icon: Icons.security,
            title: 'Two-Factor Authentication',
            value: twoFactorEnabled,
            onChanged: (value) => setState(() => twoFactorEnabled = value),
          ),
          const Divider(),

          // App Preferences
          _buildSectionTitle('App Preferences'),
          _buildSettingTile(
            icon: Icons.notifications,
            title: 'Notification Settings',
            onTap: () => _navigateToNotificationSettings(context),
          ),
          Consumer(builder: (context, ref, __) {
            return _buildSettingTileWithSwitch(
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                value: darkModeEnabled,
                onChanged: (value) {
                  if (value) {
                    ref.read(themeProvider.notifier).state = ThemeMode.dark;
                  }else {
                    ref.read(themeProvider.notifier).state = ThemeMode.light;
                  }
                  setState(() => darkModeEnabled = value);
                });
          }),
          _buildSettingTile(
            icon: Icons.language,
            title: 'Language ($currentLanguage)',
            onTap: () => _navigateToLanguageSettings(context),
          ),
          const Divider(),

          // Privacy & Support
          _buildSectionTitle('Privacy & Support'),
          _buildSettingTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            onTap: () => _navigateToPrivacyPolicy(context),
          ),
          _buildSettingTile(
            icon: Icons.help,
            title: 'Help & Support',
            onTap: () => _navigateToHelpCenter(context),
          ),
          _buildSettingTile(
            icon: Icons.logout,
            title: 'Logout',
            isDestructive: true,
            onTap: _confirmLogout,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return GestureDetector(
      onTap: () => _navigateToEditProfile(context),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: currentUser.profileImage != null
                ? FileImage(currentUser.profileImage!)
                : const AssetImage('assets/default_avatar.png')
                    as ImageProvider,
                    onBackgroundImageError: (exception, stackTrace) => Icon(Icons.person),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentUser.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                currentUser.email,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.red : null),
      title: Text(
        title,
        style: TextStyle(color: isDestructive ? Colors.red : null),
      ),
      onTap: onTap,
    );
  }

  Widget _buildSettingTileWithSwitch({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }

  // Navigation Methods
  void _navigateToEditProfile(BuildContext context) async {
    final updatedProfile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfileScreen(userProfile: currentUser),
        ));

    if (updatedProfile != null) {
      setState(() => currentUser = updatedProfile);
    }
  }

  void _navigateToChangePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
    );
  }

  void _navigateToNotificationSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationSettingsScreen(
          notificationsEnabled: notificationsEnabled,
          onSettingsChanged: (value) {
            setState(() => notificationsEnabled = value);
          },
        ),
      ),
    );
  }

  void _navigateToLanguageSettings(BuildContext context) async {
    final selectedLanguage = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LanguageSettingsScreen(currentLanguage: currentLanguage),
      ),
    );

    if (selectedLanguage != null) {
      setState(() => currentLanguage = selectedLanguage);
    }
  }

  void _navigateToPrivacyPolicy(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
    );
  }

  void _navigateToHelpCenter(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement logout logic
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// 3. Edit Profile Screen
class EditProfileScreen extends StatefulWidget {
  final UserProfile userProfile;

  const EditProfileScreen({super.key, required this.userProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _bioController;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userProfile.name);
    _emailController = TextEditingController(text: widget.userProfile.email);
    _phoneController = TextEditingController(text: widget.userProfile.phone);
    _bioController = TextEditingController(text: widget.userProfile.bio);
    _profileImage = widget.userProfile.profileImage;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    // final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   setState(() => _profileImage = File(pickedFile.path));
    // }
  }

  void _saveProfile() {
    final updatedProfile = UserProfile(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      bio: _bioController.text,
      profileImage: _profileImage,
    );
    Navigator.pop(context, updatedProfile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : const AssetImage('assets/default_avatar.png')
                        as ImageProvider,
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue,
                    child:
                        Icon(Icons.camera_alt, size: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileFormField(
              label: 'Full Name',
              icon: Icons.person,
              controller: _nameController,
            ),
            _buildProfileFormField(
              label: 'Email',
              icon: Icons.email,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            _buildProfileFormField(
              label: 'Phone Number',
              icon: Icons.phone,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            _buildProfileFormField(
              label: 'Bio (Optional)',
              icon: Icons.info,
              controller: _bioController,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileFormField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
      ),
    );
  }
}

// 4. Change Password Screen
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Implement password change logic
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password changed successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildPasswordField(
                controller: _currentPasswordController,
                label: 'Current Password',
                obscureText: _obscureCurrentPassword,
                onToggleVisibility: () => setState(
                    () => _obscureCurrentPassword = !_obscureCurrentPassword),
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controller: _newPasswordController,
                label: 'New Password',
                obscureText: _obscureNewPassword,
                onToggleVisibility: () =>
                    setState(() => _obscureNewPassword = !_obscureNewPassword),
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controller: _confirmPasswordController,
                label: 'Confirm New Password',
                obscureText: _obscureConfirmPassword,
                onToggleVisibility: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword),
                validator: (value) {
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    required VoidCallback onToggleVisibility,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
      validator: validator ??
          (value) => value?.isEmpty ?? true ? 'This field is required' : null,
    );
  }
}

// 5. Notification Settings Screen
class NotificationSettingsScreen extends StatefulWidget {
  final bool notificationsEnabled;
  final ValueChanged<bool> onSettingsChanged;

  const NotificationSettingsScreen({
    super.key,
    required this.notificationsEnabled,
    required this.onSettingsChanged,
  });

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = widget.notificationsEnabled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              widget.onSettingsChanged(_notificationsEnabled);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationSwitch(),
            const SizedBox(height: 16),
            if (_notificationsEnabled) ...[
              _buildNotificationType('Email Notifications', _emailNotifications,
                  (value) => setState(() => _emailNotifications = value)),
              _buildNotificationType('Push Notifications', _pushNotifications,
                  (value) => setState(() => _pushNotifications = value)),
              const Divider(),
              _buildNotificationPreference('Enable Sound', _soundEnabled,
                  (value) => setState(() => _soundEnabled = value)),
              _buildNotificationPreference(
                  'Enable Vibration',
                  _vibrationEnabled,
                  (value) => setState(() => _vibrationEnabled = value)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Enable Notifications',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Switch(
          value: _notificationsEnabled,
          onChanged: (value) => setState(() => _notificationsEnabled = value),
        ),
      ],
    );
  }

  Widget _buildNotificationType(
      String title, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }

  Widget _buildNotificationPreference(
      String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title),
      trailing: Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
    );
  }
}

// 6. Language Settings Screen
class LanguageSettingsScreen extends StatefulWidget {
  final String currentLanguage;

  const LanguageSettingsScreen({super.key, required this.currentLanguage});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => Navigator.pop(context, _selectedLanguage),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildLanguageOption('English', 'English'),
          _buildLanguageOption('Spanish', 'Español'),
          _buildLanguageOption('French', 'Français'),
          _buildLanguageOption('German', 'Deutsch'),
          _buildLanguageOption('Japanese', '日本語'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String languageCode, String languageName) {
    return RadioListTile(
      title: Text(languageName),
      value: languageCode,
      groupValue: _selectedLanguage,
      onChanged: (value) =>
          setState(() => _selectedLanguage = value.toString()),
    );
  }
}

// 7. Privacy Policy Screen
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Text(
          'Privacy Policy Content\n\n'
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Nullam auctor, nisl eget ultricies tincidunt, nisl nisl aliquam nisl, '
          'eget ultricies nisl nisl eget nisl. Nullam auctor, nisl eget ultricies '
          'tincidunt, nisl nisl aliquam nisl, eget ultricies nisl nisl eget nisl.\n\n'
          '1. Data Collection\nWe collect data to provide better service...\n\n'
          '2. Data Usage\nYour data is used to improve our services...\n\n'
          '3. Data Protection\nWe implement security measures to protect your data...',
          style: TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}

// 8. Help Center Screen
class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHelpItem(
            icon: Icons.help_outline,
            title: 'FAQs',
            onTap: () => _showHelpContent(
                context, 'FAQs', 'Frequently Asked Questions content...'),
          ),
          _buildHelpItem(
            icon: Icons.email,
            title: 'Contact Us',
            onTap: () => _showHelpContent(context, 'Contact Us',
                'Email: support@example.com\nPhone: +1 234 567 890'),
          ),
          _buildHelpItem(
            icon: Icons.bug_report,
            title: 'Report a Bug',
            onTap: () => _showBugReportDialog(context),
          ),
          _buildHelpItem(
            icon: Icons.feedback,
            title: 'Send Feedback',
            onTap: () => _showFeedbackDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showHelpContent(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showBugReportDialog(BuildContext context) {
    final _bugController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Report a Bug'),
        content: TextField(
          controller: _bugController,
          decoration: const InputDecoration(
            hintText: 'Describe the bug you encountered...',
          ),
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement bug report submission
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Bug report submitted. Thank you!')),
              );
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    final _feedbackController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Feedback'),
        content: TextField(
          controller: _feedbackController,
          decoration: const InputDecoration(
            hintText: 'Share your feedback with us...',
          ),
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement feedback submission
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Thank you for your feedback!')),
              );
              Navigator.pop(context);
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
