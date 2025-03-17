import 'package:flutter/material.dart';
import 'package:bharatbank/screens/transfer_screen.dart';
import 'package:bharatbank/screens/pay_bills_screen.dart';
import 'package:bharatbank/screens/add_money_screen.dart';
import 'package:bharatbank/screens/upi_qr_screen.dart';
import 'package:bharatbank/screens/recharge_screen.dart';
import 'package:bharatbank/screens/loans_screen.dart';
import 'package:bharatbank/screens/transactions_screen.dart';
import 'package:bharatbank/screens/profile_screen.dart';
import 'package:bharatbank/screens/more_screen.dart';
import 'package:bharatbank/screens/settings_screen.dart'; // New import

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _hideBalance = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Stay on Dashboard
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TransactionsScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TransferScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MoreScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('BharatBank', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications clicked')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()), // Navigate to SettingsScreen
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
              // 1. Header Section
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.blue),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Welcome, John Doe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Account Overview
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account Balance',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _hideBalance ? '****' : '₹ 25,000.00',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        IconButton(
                          icon: Icon(
                            _hideBalance ? Icons.visibility : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _hideBalance = !_hideBalance;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Last Updated: 16 Mar 2025, 10:00 AM',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 3. Quick Action Buttons
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton('Transfer', Icons.send, Colors.blue, Colors.white, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TransferScreen()),
                    );
                  }),
                  _buildActionButton('Pay Bills', Icons.payment, Colors.blue, Colors.white, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PayBillsScreen()),
                    );
                  }),
                  _buildActionButton('Add Money', Icons.add, Colors.blue, Colors.white, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddMoneyScreen()),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton('UPI/QR', Icons.qr_code, Colors.blue, Colors.white, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UpiQrScreen()),
                    );
                  }),
                  _buildActionButton('Recharge', Icons.phone_android, Colors.blue, Colors.white, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RechargeScreen()),
                    );
                  }),
                  _buildActionButton('Loans', Icons.account_balance, Colors.blue, Colors.white, () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoansScreen()),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 20),

              // 4. Recent Transactions
              const Text(
                'Recent Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
                  _buildTransaction('Grocery Store', '16 Mar 2025', '-₹500', Colors.red),
                  _buildTransaction('Salary Credit', '15 Mar 2025', '+₹30,000', Colors.green),
                  _buildTransaction('Electricity Bill', '14 Mar 2025', '-₹1,200', Colors.red),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TransactionsScreen()),
                    );
                  },
                  child: const Text('See All', style: TextStyle(color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.send), label: 'Transfer'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color bgColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: textColor, size: 30),
          ),
          const SizedBox(height: 5),
          Text(label, style: TextStyle(color: bgColor, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTransaction(String title, String date, String amount, Color amountColor) {
    return ListTile(
      leading: Icon(
        amount.startsWith('-') ? Icons.arrow_downward : Icons.arrow_upward,
        color: amountColor,
      ),
      title: Text(title, style: const TextStyle(color: Colors.blue)),
      subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
      trailing: Text(amount, style: TextStyle(color: amountColor, fontWeight: FontWeight.bold)),
    );
  }
}