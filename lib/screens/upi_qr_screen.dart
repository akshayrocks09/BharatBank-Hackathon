import 'package:flutter/material.dart';

class UpiQrScreen extends StatefulWidget {
  const UpiQrScreen({super.key});

  @override
  _UpiQrScreenState createState() => _UpiQrScreenState();
}

class _UpiQrScreenState extends State<UpiQrScreen> {
  bool _isScanned = false;
  String? _scannedCode;
  String _paymentMethod = 'UPI'; // Default payment method
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  void _simulateScan() {
    setState(() {
      _isScanned = true;
      _scannedCode = 'upi://pay?pa=john@upi&pn=John%20Doe&am=500'; // Simulated QR code
      _amountController.text = '500'; // Pre-filled amount
    });
    _showPaymentConfirmation();
  }

  void _showPaymentConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Confirm Payment', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Receiver: John Doe', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount (₹)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _paymentMethod,
                decoration: InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'UPI',
                    child: Row(
                      children: const [Icon(Icons.payment, color: Colors.blue), SizedBox(width: 10), Text('UPI')],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Card',
                    child: Row(
                      children: const [Icon(Icons.credit_card, color: Colors.blue), SizedBox(width: 10), Text('Card')],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Bank',
                    child: Row(
                      children: const [
                        Icon(Icons.account_balance, color: Colors.blue),
                        SizedBox(width: 10),
                        Text('Bank')
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _paymentMethod = value ?? 'UPI';
                  });
                },
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isScanned = false;
                _scannedCode = null;
                _amountController.clear();
                _notesController.clear();
              });
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment successful!')),
              );
              setState(() {
                _isScanned = false;
                _scannedCode = null;
                _amountController.clear();
                _notesController.clear();
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Error', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        content: const Text('Invalid QR Code'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Retry', style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showManualEntryDialog();
            },
            child: const Text('Enter Manually', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
    );
  }

  void _showManualEntryDialog() {
    final TextEditingController manualController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Enter QR Code', style: TextStyle(color: Colors.blue)),
        content: TextField(
          controller: manualController,
          decoration: InputDecoration(
            labelText: 'QR Code',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              if (manualController.text.isNotEmpty) {
                setState(() {
                  _scannedCode = manualController.text;
                  _isScanned = true;
                  _amountController.text = '500'; // Simulated amount
                });
                Navigator.pop(context);
                _showPaymentConfirmation();
              } else {
                Navigator.pop(context);
                _showErrorDialog();
              }
            },
            child: const Text('Submit', style: TextStyle(color: Colors.blue)),
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
        title: const Text('Scan QR Code', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.flashlight_on, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Flashlight toggled')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // QR Code Scanner Section (Placeholder)
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.grey[300], // Simulated camera preview
                  child: const Center(child: Text('Camera Placeholder', style: TextStyle(color: Colors.black54))),
                ),
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Positioned(
                  bottom: 20,
                  child: Text(
                    'Align the QR code within the frame to scan',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                Positioned(
                  top: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: _simulateScan, // Simulate successful scan
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: const Text('Simulate Scan'),
                      ),
                      const SizedBox(width: 20), // Spacing between buttons
                      ElevatedButton(
                        onPressed: _showErrorDialog, // Simulate error
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        child: const Text('Simulate Error'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Alternative Options
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _showManualEntryDialog,
                  child: const Text('Enter Code Manually', style: TextStyle(color: Colors.blue)),
                ),
                IconButton(
                  icon: const Icon(Icons.photo, color: Colors.blue),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Import from Gallery clicked')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}