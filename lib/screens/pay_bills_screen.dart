import 'package:flutter/material.dart';

class PayBillsScreen extends StatefulWidget {
  const PayBillsScreen({super.key});

  @override
  _PayBillsScreenState createState() => _PayBillsScreenState();
}

class _PayBillsScreenState extends State<PayBillsScreen> {
  String _selectedCategory = 'Mobile Recharge'; // Default category
  String? _selectedBiller;
  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _paymentMethod = 'UPI'; // Default payment method
  bool _isConfirmStep = false;

  // Bill categories
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Electricity', 'icon': Icons.lightbulb},
    {'name': 'Water', 'icon': Icons.water_drop},
    {'name': 'Mobile Recharge', 'icon': Icons.phone_android},
    {'name': 'Internet', 'icon': Icons.wifi},
    {'name': 'Gas', 'icon': Icons.local_gas_station},
    {'name': 'DTH', 'icon': Icons.tv},
    {'name': 'Insurance', 'icon': Icons.shield},
  ];

  // Sample billers for each category (simplified)
  final Map<String, List<String>> _billers = {
    'Electricity': ['Tata Power', 'BSES', 'MSEB'],
    'Water': ['Delhi Jal Board', 'Mumbai Water', 'BWSSB'],
    'Mobile Recharge': ['Airtel', 'Jio', 'BSNL'],
    'Internet': ['Airtel Broadband', 'Jio Fiber', 'ACT'],
    'Gas': ['Indane', 'HP Gas', 'Bharat Gas'],
    'DTH': ['Tata Sky', 'Dish TV', 'Airtel DTH'],
    'Insurance': ['LIC', 'ICICI Prudential', 'HDFC Life'],
  };

  void _validateAndProceed() {
    if (_selectedBiller != null && _customerIdController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _isConfirmStep = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  void _confirmPayment() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BillPaymentSuccessScreen(
          biller: _selectedBiller!,
          amount: _amountController.text,
          paymentMethod: _paymentMethod,
        ),
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
        title: const Text('Pay Bills', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help clicked')),
              );
            },
          ),
        ],
      ),
      body: _isConfirmStep ? _buildConfirmScreen() : _buildPayBillsForm(),
    );
  }

  Widget _buildPayBillsForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bill Category Section
            const Text(
              'Select Bill Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category['name'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category['name'];
                        _selectedBiller = null; // Reset biller on category change
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(category['icon'], color: isSelected ? Colors.white : Colors.blue),
                          const SizedBox(width: 8),
                          Text(
                            category['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Biller Details Section
            const Text(
              'Biller Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedBiller,
              hint: const Text('Select Biller'),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: _billers[_selectedCategory]!.map((biller) {
                return DropdownMenuItem(
                  value: biller,
                  child: Text(biller),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBiller = value;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _customerIdController,
              decoration: InputDecoration(
                labelText: 'Customer ID / Mobile Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.blue),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Search Biller clicked')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Biller saved')),
                );
              },
              child: const Text('Save this Biller', style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 20),

            // Amount Section
            const Text(
              'Amount',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Due Date: 20 Mar 2025', // Static for demo
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Add a Note (Optional)',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Method Section
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _paymentMethod,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: [
                DropdownMenuItem(
                  value: 'UPI',
                  child: Row(
                    children: const [
                      Icon(Icons.payment, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('UPI'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Bank Account',
                  child: Row(
                    children: const [
                      Icon(Icons.account_balance, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Bank Account'),
                    ],
                  ),
                ),
                DropdownMenuItem(
                  value: 'Wallet',
                  child: Row(
                    children: const [
                      Icon(Icons.account_balance_wallet, color: Colors.blue),
                      SizedBox(width: 10),
                      Text('Wallet'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
            const SizedBox(height: 5),
            const Text(
              'Available Balance: ₹25,000.00',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Pay Now Button
            Center(
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Pay Now', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmScreen() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Confirm Payment',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 20),
          _buildConfirmDetail('Biller', _selectedBiller!),
          _buildConfirmDetail('Amount', '₹${_amountController.text}'),
          _buildConfirmDetail('Payment Method', _paymentMethod),
          _buildConfirmDetail('Note', _noteController.text.isEmpty ? 'None' : _noteController.text),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: _confirmPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Confirm', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
        ],
      ),
    );
  }
}

class BillPaymentSuccessScreen extends StatelessWidget {
  final String biller;
  final String amount;
  final String paymentMethod;

  const BillPaymentSuccessScreen({
    super.key,
    required this.biller,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 100),
            const SizedBox(height: 20),
            const Text(
              'Bill Payment Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text('Biller: $biller', style: const TextStyle(fontSize: 18, color: Colors.blue)),
            Text('Amount: ₹$amount', style: const TextStyle(fontSize: 18, color: Colors.blue)),
            Text('Via: $paymentMethod', style: const TextStyle(fontSize: 18, color: Colors.blue)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Back to Dashboard
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('View Receipt'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PayBillsScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Pay Another'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}