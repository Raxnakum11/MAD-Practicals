import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'main.dart';
import 'numbers.dart';

class Alphabet extends StatefulWidget {
  const Alphabet({super.key});

  @override
  State<Alphabet> createState() => _AlphabetState();
}

class _AlphabetState extends State<Alphabet> {
  int _selectedIndex = 1;
  final player = AudioPlayer();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainApp()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Numbers()),
      );
    }
  }

  void playSound(String letter) async {
    await player.play(AssetSource('sounds/$letter.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Learn Alphabets",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.green[600],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green[50]!, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Tap on any letter to hear its sound!",
                style: TextStyle(
                  color: Colors.green[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: List.generate(26, (index) {
                    String letter = String.fromCharCode(65 + index);
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            playSound(letter);
                          },
                          child: Center(
                            child: Text(
                              letter,
                              style: TextStyle(
                                color: Colors.green[600],
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green[600],
        unselectedItemColor: Colors.grey[400],
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Alphabets'),
          BottomNavigationBarItem(icon: Icon(Icons.numbers), label: 'Numbers'),
        ],
      ),
    );
  }
}


