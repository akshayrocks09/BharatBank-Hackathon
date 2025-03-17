import 'package:flutter/material.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({super.key});

  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _operator = 'Airtel'; // Default operator
  String _circle = 'Delhi'; // Default circle
  String? _selectedPlan;
  String _paymentMethod = 'UPI'; // Default payment method
  bool _isConfirmStep = false;

  // Operators and circles
  final List<String> _operators = ['Airtel', 'Jio', 'Vodafone', 'BSNL'];
  final List<String> _circles = ['Delhi', 'Mumbai', 'Karnataka', 'Tamil Nadu'];

  // Sample recharge plans
  final List<Map<String, String>> _plans = [
    {'amount': '199', 'data': '1.5 GB/day', 'validity': '28 days', 'benefits': 'Unlimited Calls'},
    {'amount': '299', 'data': '2 GB/day', 'validity': '28 days', 'benefits': 'Unlimited Calls + 100 SMS/day'},
    {'amount': '499', 'data': '3 GB/day', 'validity': '56 days', 'benefits': 'Unlimited Calls + Disney+ Hotstar'},
  ];

  void _validateAndProceed() {
    if (_mobileController.text.length == 10 && (_selectedPlan != null || _amountController.text.isNotEmpty)) {
      setState(() {
        _isConfirmStep = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid mobile number and amount/plan')),
      );
    }
  }

  void _confirmRecharge() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RechargeSuccessScreen(
          mobile: _mobileController.text,
          amount: _selectedPlan ?? _amountController.text,
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
        title: const Text('Mobile Recharge', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
      body: _isConfirmStep ? _buildConfirmScreen() : _buildRechargeForm(),
    );
  }

  Widget _buildRechargeForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mobile Number Section
            const Text(
              'Mobile Number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                labelText: 'Enter Mobile Number',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.contacts, color: Colors.blue),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Select from contacts clicked')),
                    );
                  },
                ),
              ),
              onChanged: (value) {
                // Auto-detect operator logic (simplified)
                if (value.length == 10) {
                  setState(() {
                    _operator = value.startsWith('9') ? 'Airtel' : 'Jio'; // Dummy logic
                  });
                }
              },
            ),
            const SizedBox(height: 20),

            // Operator and Circle Selection
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Operator',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        value: _operator,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: _operators.map((op) {
                          return DropdownMenuItem(value: op, child: Text(op));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _operator = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Circle',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      const SizedBox(height: 5),
                      DropdownButtonFormField<String>(
                        value: _circle,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        items: _circles.map((cir) {
                          return DropdownMenuItem(value: cir, child: Text(cir));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _circle = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Recharge Amount or Plan
            const Text(
              'Recharge Amount or Plan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Amount Manually',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedPlan = null; // Clear plan if manual amount entered
                });
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 140, // Increased from 120 to 140 to fix overflow
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _plans.length,
                itemBuilder: (context, index) {
                  final plan = _plans[index];
                  final isSelected = _selectedPlan == plan['amount'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPlan = plan['amount'];
                        _amountController.text = plan['amount']!;
                      });
                    },
                    child: Container(
                      width: 150,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, // Minimize vertical space
                        children: [
                          Text(
                            '₹${plan['amount']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.blue,
                            ),
                          ),
                          Text(
                            plan['data']!,
                            style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.grey),
                          ),
                          Text(
                            'Validity: ${plan['validity']}',
                            style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.grey),
                          ),
                          Text(
                            plan['benefits']!,
                            style: TextStyle(fontSize: 12, color: isSelected ? Colors.white : Colors.grey),
                            overflow: TextOverflow.ellipsis, // Truncate long text
                          ),
                        ],
                      ),
                    ),
                  );
                },
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

            // Recharge Now Button
            Center(
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Recharge Now', style: TextStyle(fontSize: 18)),
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
            'Confirm Recharge',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 20),
          _buildConfirmDetail('Mobile Number', _mobileController.text),
          _buildConfirmDetail('Amount', '₹${_selectedPlan ?? _amountController.text}'),
          _buildConfirmDetail('Payment Method', _paymentMethod),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: _confirmRecharge,
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

class RechargeSuccessScreen extends StatelessWidget {
  final String mobile;
  final String amount;
  final String paymentMethod;

  const RechargeSuccessScreen({
    super.key,
    required this.mobile,
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
              'Recharge Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text('Mobile: $mobile', style: const TextStyle(fontSize: 18, color: Colors.blue)),
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RechargeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Do Another'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}