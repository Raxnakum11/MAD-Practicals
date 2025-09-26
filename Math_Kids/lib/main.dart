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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Comic Sans MS',
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEEB), // Sky blue
              Color(0xFFE0F6FF), // Light blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                child: const Column(
                  children: [
                    Text(
                      '🎓 Math Kids 🎓',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Let\'s Learn Math Together!',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Math Operation Cards
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      MathCard(
                        title: 'Addition',
                        icon: '➕',
                        color: Colors.green,
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
                        icon: '➖',
                        color: Colors.orange,
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
                        icon: '✖️',
                        color: Colors.purple,
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
                        icon: '➗',
                        color: Colors.red,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MathCard extends StatelessWidget {
  final String title;
  final String icon;
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
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              icon,
              style: const TextStyle(fontSize: 50),
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
        backgroundColor: getOperationColor(),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              getOperationColor().withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Score Display
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Score: $score',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Questions: $questionCount',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Question Display
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    '$num1 ${getOperationSymbol()} $num2 = ?',
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Answer Input
                  TextField(
                    controller: _answerController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Your Answer',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 24,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: getOperationColor(),
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: getOperationColor(),
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Result Display
            if (showResult)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isCorrect ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isCorrect ? Colors.green : Colors.red,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      isCorrect ? '🎉 Correct!' : '❌ Wrong!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isCorrect ? Colors.green[800] : Colors.red[800],
                      ),
                    ),
                    if (!isCorrect)
                      Text(
                        'Correct answer: $correctAnswer',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red[700],
                        ),
                      ),
                  ],
                ),
              ),
            
            const Spacer(),
            
            // Action Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: showResult ? nextQuestion : checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: getOperationColor(),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  showResult ? 'Next Question' : 'Check Answer',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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