import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  String _selectedLanguage = 'en'; // Default language
  bool _mediaAutoDownload = true;
  bool _cameraPermission = true;
  bool _micPermission = false;
  bool _contactsPermission = true;
  bool _biometricLogin = false;
  String _autoLogout = '5 min'; // Default auto-logout time
  bool _highContrast = false;
  String _textSize = 'Medium'; // Default text size
  bool _vibrationFeedback = true;
  bool _betaMode = false;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedLanguage = prefs.getString('selected_language') ?? 'en';
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
        title: const Text('More Settings', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search clicked')),
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
              // Data & Storage
              _buildCategoryCard('Data & Storage', [
                ListTile(
                  leading: const Icon(Icons.storage, color: Colors.blue),
                  title: const Text('Manage Cache'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cache cleared')),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    child: const Text('Clear'),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.data_usage, color: Colors.blue),
                  title: Text('Storage Usage'),
                  subtitle: Text('Total: 150 MB, Available: 50 MB'),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.download, color: Colors.blue),
                  title: const Text('Media Auto-Download'),
                  value: _mediaAutoDownload,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _mediaAutoDownload = value;
                    });
                  },
                ),
              ]),

              // Permissions
              _buildCategoryCard('Permissions', [
                SwitchListTile(
                  secondary: const Icon(Icons.camera_alt, color: Colors.blue),
                  title: const Text('Camera'),
                  value: _cameraPermission,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _cameraPermission = value;
                    });
                  },
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.mic, color: Colors.blue),
                  title: const Text('Microphone'),
                  value: _micPermission,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _micPermission = value;
                    });
                  },
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.contacts, color: Colors.blue),
                  title: const Text('Contacts'),
                  value: _contactsPermission,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _contactsPermission = value;
                    });
                  },
                ),
              ]),

              // Language & Region
              _buildCategoryCard('Language & Region', [
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.blue),
                  title: const Text('Preferred Language'),
                  trailing: DropdownButton<String>(
                    value: _selectedLanguage,
                    items: [
                      DropdownMenuItem(value: 'en', child: const Text('English')),
                      DropdownMenuItem(value: 'hi', child: const Text('हिंदी (Hindi)')),
                      DropdownMenuItem(value: 'mr', child: const Text('मराठी (Marathi)')),
                    ],
                    onChanged: (value) {
                      if (value != null) _saveLanguage(value);
                    },
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.blue),
                  title: const Text('Region Settings'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Region Settings clicked')),
                    );
                  },
                ),
              ]),

              // Security
              _buildCategoryCard('Security', [
                SwitchListTile(
                  secondary: const Icon(Icons.fingerprint, color: Colors.blue),
                  title: const Text('Biometric Login'),
                  value: _biometricLogin,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _biometricLogin = value;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.timer_off, color: Colors.blue),
                  title: const Text('Auto Logout'),
                  trailing: DropdownButton<String>(
                    value: _autoLogout,
                    items: const [
                      DropdownMenuItem(value: '1 min', child: Text('1 min')),
                      DropdownMenuItem(value: '5 min', child: Text('5 min')),
                      DropdownMenuItem(value: '10 min', child: Text('10 min')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _autoLogout = value ?? '5 min';
                      });
                    },
                  ),
                ),
              ]),

              // Backup & Restore
              _buildCategoryCard('Backup & Restore', [
                ListTile(
                  leading: const Icon(Icons.backup, color: Colors.blue),
                  title: const Text('Backup Data'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Backup started')),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                    child: const Text('Backup'),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.restore, color: Colors.blue),
                  title: const Text('Restore from Backup'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Restore clicked')),
                    );
                  },
                ),
              ]),

              // Accessibility
              _buildCategoryCard('Accessibility', [
                SwitchListTile(
                  secondary: const Icon(Icons.contrast, color: Colors.blue),
                  title: const Text('High Contrast Mode'),
                  value: _highContrast,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _highContrast = value;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.text_fields, color: Colors.blue),
                  title: const Text('Text Size'),
                  trailing: DropdownButton<String>(
                    value: _textSize,
                    items: const [
                      DropdownMenuItem(value: 'Small', child: Text('Small')),
                      DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'Large', child: Text('Large')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _textSize = value ?? 'Medium';
                      });
                    },
                  ),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.vibration, color: Colors.blue),
                  title: const Text('Vibration Feedback'),
                  value: _vibrationFeedback,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _vibrationFeedback = value;
                    });
                  },
                ),
              ]),

              // Experimental Features
              _buildCategoryCard('Experimental Features', [
                SwitchListTile(
                  secondary: const Icon(Icons.science, color: Colors.blue), // Replaced Icons.experiment with Icons.science
                  title: const Text('Beta Mode'),
                  value: _betaMode,
                  activeColor: Colors.blue,
                  onChanged: (value) {
                    setState(() {
                      _betaMode = value;
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.bug_report, color: Colors.blue),
                  title: const Text('Performance Logs'),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Send logs clicked')),
                    );
                  },
                ),
              ]),

              // Action Buttons
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _showConfirmationDialog('Reset to Default', () {
                    setState(() {
                      _mediaAutoDownload = true;
                      _cameraPermission = true;
                      _micPermission = false;
                      _contactsPermission = true;
                      _biometricLogin = false;
                      _autoLogout = '5 min';
                      _highContrast = false;
                      _textSize = 'Medium';
                      _vibrationFeedback = true;
                      _betaMode = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Settings reset to default')),
                    );
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Reset to Default', style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Help & Support clicked')),
                    );
                  },
                  child: const Text('Help & Support', style: TextStyle(color: Colors.blue, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            ...children,
          ],
        ),
      ),
    );
  }
}