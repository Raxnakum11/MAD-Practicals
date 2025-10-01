import 'package:flutter/material.dart';

void main() {
  runApp(ITQuizApp());
}

class ITQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IT Quizzer",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SubjectPage(),
    );
  }
}

// Page 1: Choose Subject
class SubjectPage extends StatelessWidget {
  final List<String> subjects = ["C Programming", "Java", "Python"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Subject"),backgroundColor: Colors.deepPurple,),
      body: ListView.builder(
        itemCount: subjects.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(subjects[index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(subject: subjects[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Page 2: Quiz Page
class QuizPage extends StatefulWidget {
  final String subject;
  QuizPage({required this.subject});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;

  // Updated IT quiz questions for each subject
  final Map<String, List<Map<String, Object>>> quizData = {
    "C Programming": [
      {
        "question":
            "Which function is used to allocate memory dynamically in C?",
        "options": ["malloc()", "calloc()", "alloc()", "new()"],
        "answer": "malloc()",
      },
      {
        "question": "What is the size of int data type in C (typically)?",
        "options": ["2 bytes", "4 bytes", "8 bytes", "1 byte"],
        "answer": "4 bytes",
      },
      {
        "question": "Which header file contains the declaration of printf()?",
        "options": ["<stdio.h>", "<stdlib.h>", "<string.h>", "<math.h>"],
        "answer": "<stdio.h>",
      },
      {
        "question": "What does the '&' operator do in C?",
        "options": [
          "Logical AND",
          "Bitwise AND",
          "Address of",
          "All of the above",
        ],
        "answer": "All of the above",
      },
    ],
    "Java": [
      {
        "question": "Which of these is NOT a Java feature?",
        "options": [
          "Object-Oriented",
          "Platform Independent",
          "Pointer Arithmetic",
          "Multithreaded",
        ],
        "answer": "Pointer Arithmetic",
      },
      {
        "question": "What is the default value of boolean variable in Java?",
        "options": ["true", "false", "0", "null"],
        "answer": "false",
      },
      {
        "question":
            "Which method is called when an object is garbage collected?",
        "options": ["finalize()", "delete()", "clear()", "dispose()"],
        "answer": "finalize()",
      },
      {
        "question": "Which collection class allows duplicate elements?",
        "options": ["HashSet", "LinkedHashSet", "ArrayList", "TreeSet"],
        "answer": "ArrayList",
      },
    ],
    "Python": [
      {
        "question": "Which of the following is a mutable data type in Python?",
        "options": ["tuple", "string", "list", "frozenset"],
        "answer": "list",
      },
      {
        "question": "What does the 'len()' function return?",
        "options": [
          "Length of object",
          "Size in bytes",
          "Number of elements",
          "Both A and C",
        ],
        "answer": "Both A and C",
      },
      {
        "question": "Which keyword is used to define a function in Python?",
        "options": ["function", "def", "define", "func"],
        "answer": "def",
      },
      {
        "question": "What is the output of: print(2 ** 3)?",
        "options": ["6", "8", "9", "23"],
        "answer": "8",
      },
    ],
  };

  void checkAnswer(String selected) {
    String correctAnswer =
        quizData[widget.subject]![currentQuestion]["answer"] as String;

    if (selected == correctAnswer) {
      score++;
    }

    setState(() {
      if (currentQuestion < quizData[widget.subject]!.length - 1) {
        currentQuestion++;
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => ResultPage(
                  score: score,
                  total: quizData[widget.subject]!.length,
                ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var questionData = quizData[widget.subject]![currentQuestion];
    return Scaffold(
      appBar: AppBar(title: Text("${widget.subject} Quiz")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Q${currentQuestion + 1}: ${questionData["question"]}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ...(questionData["options"] as List<String>).map((option) {
              return ListTile(
                title: Text(option),
                onTap: () => checkAnswer(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

// Page 3: Result Page
class ResultPage extends StatelessWidget {
  final int score;
  final int total;

  ResultPage({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Result"),backgroundColor: Colors.amber,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Score: $score / $total",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Go Back"),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
