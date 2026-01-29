import 'package:flutter/material.dart';
import 'screens/calculator_screen.dart';

void main() {
  runApp(const VCalculator());
}

class VCalculator extends StatelessWidget {
  const VCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'V-Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}
