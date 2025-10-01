import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(EmiCalculatorApp());
}

class EmiCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMI Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: EmiCalculatorScreen(),
    );
  }
}

class EmiCalculatorScreen extends StatefulWidget {
  @override
  _EmiCalculatorScreenState createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  final _loanController = TextEditingController();
  final _interestController = TextEditingController();
  final _tenureController = TextEditingController();

  double? _emiResult;

  void _calculateEMI() {
    double principal = double.tryParse(_loanController.text) ?? 0;
    double rate = double.tryParse(_interestController.text) ?? 0;
    int months = int.tryParse(_tenureController.text) ?? 0;

    if (principal > 0 && rate > 0 && months > 0) {
      double monthlyRate = rate / 12 / 100;
      double emi = (principal * monthlyRate * pow(1 + monthlyRate, months)) /
          (pow(1 + monthlyRate, months) - 1);

      setState(() {
        _emiResult = emi;
      });
    } else {
      setState(() {
        _emiResult = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EMI Calculator"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Loan Amount
            TextField(
              controller: _loanController,
              decoration: InputDecoration(
                labelText: 'Loan Amount',
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),

            // Interest Rate
            TextField(
              controller: _interestController,
              decoration: InputDecoration(
                labelText: 'Interest Rate (per annum %)',
                prefixIcon: Icon(Icons.percent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),

            // Tenure
            TextField(
              controller: _tenureController,
              decoration: InputDecoration(
                labelText: 'Tenure (in months)',
                prefixIcon: Icon(Icons.calendar_month),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Calculate Button
            ElevatedButton(
              onPressed: _calculateEMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 52, 224, 135),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Calculate EMI",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            SizedBox(height: 30),

            // Result
            _emiResult != null
                ? Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 79, 148, 232),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      "Your Monthly EMI is: ₹${_emiResult!.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Text(
                    "Enter all values to calculate EMI",
                    style: TextStyle(color: const Color.fromARGB(255, 218, 164, 164), fontSize: 16),
                  ),
          ],
        ),
      ),
    );
  }
}