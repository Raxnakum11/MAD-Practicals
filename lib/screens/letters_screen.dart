import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class LettersScreen extends StatefulWidget {
  const LettersScreen({super.key});

  @override
  State<LettersScreen> createState() => _LettersScreenState();
}

class _LettersScreenState extends State<LettersScreen>
    with TickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<Map<String, dynamic>> letters = [
    {'letter': 'A', 'word': 'Apple', 'emoji': '🍎', 'color': Colors.red},
    {'letter': 'B', 'word': 'Ball', 'emoji': '⚽', 'color': Colors.blue},
    {'letter': 'C', 'word': 'Cat', 'emoji': '🐱', 'color': Colors.orange},
    {'letter': 'D', 'word': 'Dog', 'emoji': '🐶', 'color': Colors.brown},
    {'letter': 'E', 'word': 'Elephant', 'emoji': '🐘', 'color': Colors.grey},
    {'letter': 'F', 'word': 'Fish', 'emoji': '🐟', 'color': Colors.cyan},
    {'letter': 'G', 'word': 'Grapes', 'emoji': '🍇', 'color': Colors.purple},
    {'letter': 'H', 'word': 'House', 'emoji': '🏠', 'color': Colors.teal},
    {'letter': 'I', 'word': 'Ice cream', 'emoji': '🍦', 'color': Colors.pink},
    {'letter': 'J', 'word': 'Juice', 'emoji': '🧃', 'color': Colors.amber},
    {'letter': 'K', 'word': 'Kite', 'emoji': '🪁', 'color': Colors.indigo},
    {'letter': 'L', 'word': 'Lion', 'emoji': '🦁', 'color': Colors.yellow},
    {'letter': 'M', 'word': 'Moon', 'emoji': '🌙', 'color': Colors.deepPurple},
    {'letter': 'N', 'word': 'Nest', 'emoji': '🪺', 'color': Colors.green},
    {
      'letter': 'O',
      'word': 'Orange',
      'emoji': '🍊',
      'color': Colors.deepOrange,
    },
    {'letter': 'P', 'word': 'Penguin', 'emoji': '🐧', 'color': Colors.blueGrey},
    {'letter': 'Q', 'word': 'Queen', 'emoji': '👸', 'color': Colors.pinkAccent},
    {'letter': 'R', 'word': 'Rainbow', 'emoji': '🌈', 'color': Colors.red},
    {'letter': 'S', 'word': 'Sun', 'emoji': '☀️', 'color': Colors.yellow},
    {'letter': 'T', 'word': 'Tree', 'emoji': '🌳', 'color': Colors.green},
    {'letter': 'U', 'word': 'Umbrella', 'emoji': '☂️', 'color': Colors.blue},
    {'letter': 'V', 'word': 'Violin', 'emoji': '🎻', 'color': Colors.brown},
    {'letter': 'W', 'word': 'Whale', 'emoji': '🐋', 'color': Colors.lightBlue},
    {'letter': 'X', 'word': 'Xylophone', 'emoji': '🎹', 'color': Colors.purple},
    {'letter': 'Y', 'word': 'Yacht', 'emoji': '🛥️', 'color': Colors.blue},
    {'letter': 'Z', 'word': 'Zebra', 'emoji': '🦓', 'color': Colors.black},
  ];

  @override
  void initState() {
    super.initState();
    _setupTts();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  void _setupTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.6);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.2);
  }

  void _speakLetter(String letter, String word) async {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
    await flutterTts.speak("$letter for $word");
  }

  @override
  void dispose() {
    _animationController.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '📚 Learn Letters',
          style: GoogleFonts.comicNeue(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFF6B73FF),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6B73FF), Color(0xFF9A56FF)],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: letters.length,
          itemBuilder: (context, index) {
            final letterData = letters[index];
            return AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: GestureDetector(
                    onTap:
                        () => _speakLetter(
                          letterData['letter'],
                          letterData['word'],
                        ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: letterData['color'].withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Letter
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: letterData['color'],
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: letterData['color'].withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                letterData['letter'],
                                style: GoogleFonts.comicNeue(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Emoji
                          Text(
                            letterData['emoji'],
                            style: const TextStyle(fontSize: 32),
                          ),

                          const SizedBox(height: 8),

                          // Word
                          Text(
                            letterData['word'],
                            style: GoogleFonts.comicNeue(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: letterData['color'],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Sound icon
                          Icon(
                            Icons.volume_up,
                            color: letterData['color'].withOpacity(0.7),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await flutterTts.speak("Tap any letter to hear its sound and word!");
        },
        backgroundColor: const Color(0xFFFF6B6B),
        child: const Icon(Icons.help_outline, color: Colors.white),
      ),
    );
  }
}
