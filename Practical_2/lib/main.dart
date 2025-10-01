import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MathKidsApp());
}

class MathKidsApp extends StatelessWidget {
  const MathKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Kids',
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const MathKidsHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MathKidsHomePage extends StatelessWidget {
  const MathKidsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Math Kids',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xFFFFF8DC), // Cream background
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'Let\'s Learn Math!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 60),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  MathCard(
                    title: 'Addition',
                    color: Colors.blue,
                    icon: Icons.add,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MathGameScreen(
                            operation: MathOperation.addition,
                          ),
                        ),
                      );
                    },
                  ),
                  MathCard(
                    title: 'Subtraction',
                    color: Colors.pink,
                    icon: Icons.remove,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MathGameScreen(
                            operation: MathOperation.subtraction,
                          ),
                        ),
                      );
                    },
                  ),
                  MathCard(
                    title: 'Multiplication',
                    color: Colors.green,
                    icon: Icons.close,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MathGameScreen(
                            operation: MathOperation.multiplication,
                          ),
                        ),
                      );
                    },
                  ),
                  MathCard(
                    title: 'Division',
                    color: Colors.amber,
                    icon: Icons.more_horiz,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MathGameScreen(
                            operation: MathOperation.division,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MathCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const MathCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

enum MathOperation { addition, subtraction, multiplication, division }

class MathGameScreen extends StatefulWidget {
  final MathOperation operation;

  const MathGameScreen({super.key, required this.operation});

  @override
  State<MathGameScreen> createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen> {
  int num1 = 0;
  int num2 = 0;
  int correctAnswer = 0;
  int userAnswer = 0;
  int score = 0;
  int questionCount = 0;
  bool showResult = false;
  bool isCorrect = false;
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    final random = Random();
    setState(() {
      switch (widget.operation) {
        case MathOperation.addition:
          num1 = random.nextInt(50) + 1;
          num2 = random.nextInt(50) + 1;
          correctAnswer = num1 + num2;
          break;
        case MathOperation.subtraction:
          num1 = random.nextInt(50) + 20;
          num2 = random.nextInt(num1);
          correctAnswer = num1 - num2;
          break;
        case MathOperation.multiplication:
          num1 = random.nextInt(12) + 1;
          num2 = random.nextInt(12) + 1;
          correctAnswer = num1 * num2;
          break;
        case MathOperation.division:
          correctAnswer = random.nextInt(12) + 1;
          num2 = random.nextInt(12) + 1;
          num1 = correctAnswer * num2;
          break;
      }
      showResult = false;
      _answerController.clear();
    });
  }

  void checkAnswer() {
    if (_answerController.text.isEmpty) return;
    
    setState(() {
      userAnswer = int.tryParse(_answerController.text) ?? 0;
      isCorrect = userAnswer == correctAnswer;
      showResult = true;
      questionCount++;
      
      if (isCorrect) {
        score++;
      }
    });
  }

  void nextQuestion() {
    generateQuestion();
  }

  String getOperationSymbol() {
    switch (widget.operation) {
      case MathOperation.addition:
        return '+';
      case MathOperation.subtraction:
        return '-';
      case MathOperation.multiplication:
        return '×';
      case MathOperation.division:
        return '÷';
    }
  }

  String getOperationTitle() {
    switch (widget.operation) {
      case MathOperation.addition:
        return 'Addition';
      case MathOperation.subtraction:
        return 'Subtraction';
      case MathOperation.multiplication:
        return 'Multiplication';
      case MathOperation.division:
        return 'Division';
    }
  }

  Color getOperationColor() {
    switch (widget.operation) {
      case MathOperation.addition:
        return Colors.green;
      case MathOperation.subtraction:
        return Colors.orange;
      case MathOperation.multiplication:
        return Colors.purple;
      case MathOperation.division:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getOperationTitle()),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color(0xFFFFF8DC), // Cream background
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            
            // Question Display
            Text(
              '$num1 ${getOperationSymbol()} $num2 = ?',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Answer Input
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF8B4), // Light yellow
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: TextField(
                controller: _answerController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: showResult ? '' : 'Enter your answer',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18),
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Check Button
            if (!showResult)
              SizedBox(
                width: 120,
                height: 50,
                child: ElevatedButton(
                  onPressed: checkAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Check',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            
            const SizedBox(height: 20),
            
            // Result Display
            if (showResult)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: isCorrect ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      isCorrect ? 'Great job! 🎉' : 'Try again! ❌',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: nextQuestion,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Next Question',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }
}