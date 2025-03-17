import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'John Doe');
  final TextEditingController _phoneController = TextEditingController(text: '9876543210');
  final String _email = 'john.doe@example.com'; // Static for demo
  String _selectedLanguage = 'en'; // Default language
  bool _twoFactorAuth = false;
  bool _pushNotifications = true;
  bool _transactionAlerts = true;
  bool _appLock = false;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selected_language') ?? 'en'; // Fixed syntax
    });
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  void _showConfirmationDialog(String action, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm $action'),
        content: Text('Are you sure you want to $action?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              Navigator.pop(context);
            },
            child: const Text('Confirm', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
        title: const Text('Profile Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings saved')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Change profile picture clicked')),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.person, size: 60, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _nameController,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.edit, color: Colors.blue),
                            ),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    Text(_email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _phoneController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.edit, color: Colors.blue),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('OTP sent for verification')),
                            );
                          },
                          child: const Text('Verify', style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),

              // Security Settings
              const Text(
                'Security Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              ListTile(
                title: const Text('Change Password'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Change Password clicked')),
                  );
                },
              ),
              SwitchListTile(
                title: const Text('Two-Factor Authentication'),
                value: _twoFactorAuth,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _twoFactorAuth = value;
                  });
                },
              ),

              // Language Preferences
              const Text(
                'Language Preferences',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _selectedLanguage,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        const Text('English'),
                        if (_selectedLanguage == 'en') const SizedBox(width: 10),
                        if (_selectedLanguage == 'en') const Icon(Icons.check, color: Colors.blue),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'hi',
                    child: Row(
                      children: [
                        const Text('हिंदी (Hindi)'),
                        if (_selectedLanguage == 'hi') const SizedBox(width: 10),
                        if (_selectedLanguage == 'hi') const Icon(Icons.check, color: Colors.blue),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'mr',
                    child: Row(
                      children: [
                        const Text('मराठी (Marathi)'),
                        if (_selectedLanguage == 'mr') const SizedBox(width: 10),
                        if (_selectedLanguage == 'mr') const Icon(Icons.check, color: Colors.blue),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) _saveLanguage(value);
                },
              ),
              const SizedBox(height: 20),

              // Notification Settings
              const Text(
                'Notification Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SwitchListTile(
                title: const Text('Push Notifications'),
                value: _pushNotifications,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _pushNotifications = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Transaction Alerts'),
                value: _transactionAlerts,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _transactionAlerts = value;
                  });
                },
              ),

              // Privacy Settings
              const Text(
                'Privacy Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              ListTile(
                title: const Text('Manage Permissions'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Manage Permissions clicked')),
                  );
                },
              ),
              SwitchListTile(
                title: const Text('App Lock (Biometric)'),
                value: _appLock,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _appLock = value;
                  });
                },
              ),

              // Payment Methods
              const Text(
                'Payment Methods',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              ListTile(
                title: const Text('Saved Cards'),
                subtitle: const Text('Visa **** 1234'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {},
                ),
              ),
              ListTile(
                title: const Text('UPI Accounts'),
                subtitle: const Text('john@upi'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {},
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add Payment Method clicked')),
                  );
                },
                child: const Text('Add New Payment Method', style: TextStyle(color: Colors.blue)),
              ),
              const SizedBox(height: 20),

              // App Preferences
              const Text(
                'App Preferences',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SwitchListTile(
                title: const Text('Dark Mode'),
                value: _isDarkMode,
                activeColor: Colors.blue,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
              ),
              ListTile(
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Privacy Policy clicked')),
                  );
                },
              ),
              ListTile(
                title: const Text('Terms and Conditions'),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Terms and Conditions clicked')),
                  );
                },
              ),

              // Action Buttons
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _showConfirmationDialog('Logout', () {
                    Navigator.pop(context); // Simulate logout
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Logout', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () => _showConfirmationDialog('Delete Account', () {
                    Navigator.pop(context); // Simulate account deletion
                  }),
                  child: const Text('Delete Account', style: TextStyle(color: Colors.red)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}