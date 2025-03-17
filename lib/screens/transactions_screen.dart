import 'package:flutter/material.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _filter = 'All'; // Default filter

  // Sample transaction data
  final List<Map<String, dynamic>> _transactions = [
    {'type': 'sent', 'name': 'Ravi Kumar', 'amount': -500, 'ref': 'TXN123', 'date': '17 Mar 2025, 10:30 AM'},
    {'type': 'received', 'name': 'Salary', 'amount': 30000, 'ref': 'TXN124', 'date': '17 Mar 2025, 09:00 AM'},
    {'type': 'sent', 'name': 'Mobile Recharge', 'amount': -200, 'ref': 'TXN125', 'date': '16 Mar 2025, 03:15 PM'},
    {'type': 'sent', 'name': 'Electricity Bill', 'amount': -1200, 'ref': 'TXN126', 'date': '15 Mar 2025, 11:45 AM'},
    {'type': 'received', 'name': 'Priya Sharma', 'amount': 1000, 'ref': 'TXN127', 'date': '15 Mar 2025, 08:20 AM'},
  ];

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter Transactions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text('All', style: TextStyle(color: Colors.blue)),
                onTap: () {
                  setState(() {
                    _filter = 'All';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Sent', style: TextStyle(color: Colors.blue)),
                onTap: () {
                  setState(() {
                    _filter = 'Sent';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Received', style: TextStyle(color: Colors.blue)),
                onTap: () {
                  setState(() {
                    _filter = 'Received';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Pending', style: TextStyle(color: Colors.blue)),
                onTap: () {
                  setState(() {
                    _filter = 'Pending';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter transactions based on _filter
    final filteredTransactions = _filter == 'All'
        ? _transactions
        : _transactions.where((txn) => _filter.toLowerCase() == txn['type']).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Transactions', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterModal,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Balance Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  '₹ 25,000.00',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ],
            ),
          ),

          // Transactions List
          Expanded(
            child: ListView.builder(
              itemCount: filteredTransactions.length + 1, // +1 for date headers
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildDateHeader('Today'); // Simplified for demo
                }
                final txn = filteredTransactions[index - 1];
                final isSent = txn['amount'] < 0;
                return _buildTransactionCard(
                  icon: isSent ? Icons.arrow_upward : Icons.arrow_downward,
                  name: txn['name'],
                  amount: '₹${txn['amount'].abs().toStringAsFixed(2)}',
                  ref: txn['ref'],
                  date: txn['date'],
                  amountColor: isSent ? Colors.red : Colors.green,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Start a new transaction')),
          );
          // Add navigation to TransferScreen or similar here if needed
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildDateHeader(String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        color: Colors.grey[200],
        child: Text(
          date,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildTransactionCard({
    required IconData icon,
    required String name,
    required String amount,
    required String ref,
    required String date,
    required Color amountColor,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: amountColor.withOpacity(0.1),
          child: Icon(icon, color: amountColor),
        ),
        title: Text(
          name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ref, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Text(
          amount,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: amountColor),
        ),
      ),
    );
  }
}