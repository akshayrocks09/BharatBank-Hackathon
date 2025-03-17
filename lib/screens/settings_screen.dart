import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _twoFactorAuth = false;
  bool _biometricLogin = false;
  bool _transactionAlerts = true;
  bool _promoNotifications = false;
  bool _soundVibration = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Settings Section
          const _SectionHeader(title: 'Account Settings'),
          _buildSettingsCard(
            icon: Icons.person,
            title: 'Edit Profile',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit Profile clicked')),
              );
            },
          ),
          _buildSettingsCard(
            icon: Icons.phone,
            title: 'Change Phone Number',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change Phone Number clicked')),
              );
            },
          ),
          _buildSettingsCard(
            icon: Icons.account_balance,
            title: 'Linked Bank Accounts',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Linked Bank Accounts clicked')),
              );
            },
          ),

          // Security Settings Section
          const _SectionHeader(title: 'Security Settings'),
          _buildSettingsCard(
            icon: Icons.lock,
            title: 'Change Password',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change Password clicked')),
              );
            },
          ),
          _buildSwitchCard(
            icon: Icons.security,
            title: 'Enable Two-Factor Authentication',
            value: _twoFactorAuth,
            onChanged: (value) {
              setState(() {
                _twoFactorAuth = value;
              });
            },
          ),
          _buildSwitchCard(
            icon: Icons.fingerprint,
            title: 'Biometric Login',
            value: _biometricLogin,
            onChanged: (value) {
              setState(() {
                _biometricLogin = value;
              });
            },
          ),

          // Notifications Section
          const _SectionHeader(title: 'Notifications'),
          _buildSwitchCard(
            icon: Icons.notifications_active,
            title: 'Transaction Alerts',
            value: _transactionAlerts,
            onChanged: (value) {
              setState(() {
                _transactionAlerts = value;
              });
            },
          ),
          _buildSwitchCard(
            icon: Icons.campaign,
            title: 'Promotional Notifications',
            value: _promoNotifications,
            onChanged: (value) {
              setState(() {
                _promoNotifications = value;
              });
            },
          ),
          _buildSwitchCard(
            icon: Icons.vibration,
            title: 'Sound and Vibration',
            value: _soundVibration,
            onChanged: (value) {
              setState(() {
                _soundVibration = value;
              });
            },
          ),

          // App Preferences Section
          const _SectionHeader(title: 'App Preferences'),
          _buildSettingsCard(
            icon: Icons.language,
            title: 'Language Selection',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Language Selection clicked')),
              );
            },
          ),
          _buildSwitchCard(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
          ),
          _buildSettingsCard(
            icon: Icons.currency_rupee,
            title: 'Default Currency',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Default Currency clicked')),
              );
            },
          ),

          // About and Support Section
          const _SectionHeader(title: 'About and Support'),
          _buildSettingsCard(
            icon: Icons.help,
            title: 'Help Center',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help Center clicked')),
              );
            },
          ),
          _buildSettingsCard(
            icon: Icons.support_agent,
            title: 'Contact Support',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact Support clicked')),
              );
            },
          ),
          _buildSettingsCard(
            icon: Icons.info,
            title: 'App Version',
            subtitle: '1.0.0',
            onTap: null, // No action, just display
          ),

          // Log Out Button
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Log Out', style: TextStyle(color: Colors.red)),
                    content: const Text('Are you sure you want to log out?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Logged out')),
                          );
                          // Add navigation to login screen if needed
                        },
                        child: const Text('Log Out', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Log Out', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontSize: 16, color: Colors.blue)),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)) : null,
        trailing: onTap != null ? const Icon(Icons.arrow_forward_ios, color: Colors.blue) : null,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _buildSwitchCard({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontSize: 16, color: Colors.blue)),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}