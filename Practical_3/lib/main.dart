import 'package:flutter/material.dart';

void main() {
  runApp(WordMatchApp());
}

class WordMatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image & Spelling Match',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'ComicSans', 
      ),
      home: WordMatchScreen(),
    );
  }
}

class WordMatchScreen extends StatefulWidget {
  @override
  _WordMatchScreenState createState() => _WordMatchScreenState();
}

class _WordMatchScreenState extends State<WordMatchScreen> {

  final List<Map<String, dynamic>> _questions = [
    {
      'image': 'assets/images/apple.jpg',
      'correct': 'APPLE',
      'options': ['APLE', 'APPLE', 'APPEL'],
    },
    {
      'image': 'assets/images/car.jpg',
      'correct': 'CAR',
      'options': ['CAR', 'CARR', 'KAR'],
    },
    {
      'image': 'assets/images/cat.jpg',
      'correct': 'CAT',
      'options': ['CATT', 'CAT', 'KAT'],
    },
  ];

  int _currentIndex = 0;
  bool _answered = false;
  String _selected = '';

  void _checkAnswer(String answer) {
    setState(() {
      _answered = true;
      _selected = answer;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _answered = false;
        _selected = '';
        if (_currentIndex < _questions.length - 1) {
          _currentIndex++;
        } else {
          _currentIndex = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var question = _questions[_currentIndex];

    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(title: Text("Image & Spelling Match"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(question['image']),
              ),
            ),
            SizedBox(height: 30),

            // Options
            Column(
              children:
                  question['options'].map<Widget>((option) {
                    bool isCorrect = option == question['correct'];
                    bool isSelected = option == _selected;

                    return GestureDetector(
                      onTap: _answered ? null : () => _checkAnswer(option),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              _answered
                                  ? (isSelected
                                      ? (isCorrect ? Colors.green : Colors.red)
                                      : Colors.white)
                                  : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 4,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color:
                                  _answered && isSelected
                                      ? Colors.white
                                      : Colors.purple.shade700,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
