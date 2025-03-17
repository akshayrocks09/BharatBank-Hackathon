import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _paymentMethod = 'UPI'; // Default payment method
  bool _isConfirmStep = false;

  void _validateAndProceed() {
    if (_recipientController.text.isNotEmpty && _amountController.text.isNotEmpty) {
      setState(() {
        _isConfirmStep = true;
      });
    } else {
      _shakeAnimation();
    }
  }

  void _shakeAnimation() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter recipient and amount')),
    );
  }

  void _confirmTransfer() {
    // Simulate transfer success
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TransferSuccessScreen(
        recipient: _recipientController.text,
        amount: _amountController.text,
        paymentMethod: _paymentMethod,
      )),
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
        title: const Text('Transfer Money', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _isConfirmStep ? _buildConfirmScreen() : _buildTransferForm(),
    );
  }

  Widget _buildTransferForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipient Section
            const Text(
              'Recipient',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(
                labelText: 'Enter UPI ID / Bank Account',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.qr_code_scanner, color: Colors.blue),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('QR Scan clicked')),
                    );
                  },
                ),
              ),
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
              keyboardType: TextInputType.number, // Phone's numeric keyboard still appears
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                prefixText: '₹ ',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Available Balance: ₹25,000.00',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Note Section
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
            const SizedBox(height: 20),

            // Continue Button
            Center(
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Continue', style: TextStyle(fontSize: 18)),
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
            'Confirm Transfer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 20),
          _buildConfirmDetail('Recipient', _recipientController.text),
          _buildConfirmDetail('Amount', '₹${_amountController.text}'),
          _buildConfirmDetail('Payment Method', _paymentMethod),
          _buildConfirmDetail('Note', _noteController.text.isEmpty ? 'None' : _noteController.text),
          const SizedBox(height: 20),
          if (_paymentMethod == 'UPI')
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter UPI PIN',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: _confirmTransfer,
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

class TransferSuccessScreen extends StatelessWidget {
  final String recipient;
  final String amount;
  final String paymentMethod;

  const TransferSuccessScreen({
    super.key,
    required this.recipient,
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
              'Transfer Successful!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            Text('To: $recipient', style: const TextStyle(fontSize: 18, color: Colors.blue)),
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
                  child: const Text('View Transaction'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TransferScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Make Another'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}