import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const BharatBankApp());
}

class BharatBankApp extends StatelessWidget {
  const BharatBankApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}