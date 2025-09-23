import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class NumbersScreen extends StatefulWidget {
  const NumbersScreen({super.key});

  @override
  State<NumbersScreen> createState() => _NumbersScreenState();
}

class _NumbersScreenState extends State<NumbersScreen>
    with TickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  late AnimationController _animationController;
  late Animation<double> _bounceAnimation;

  final List<Map<String, dynamic>> numbers = [
    {
      'number': '1',
      'word': 'One',
      'items': '🍎',
      'color': Colors.red,
      'count': 1,
    },
    {
      'number': '2',
      'word': 'Two',
      'items': '👀',
      'color': Colors.blue,
      'count': 2,
    },
    {
      'number': '3',
      'word': 'Three',
      'items': '🌟🌟🌟',
      'color': Colors.yellow,
      'count': 3,
    },
    {
      'number': '4',
      'word': 'Four',
      'items': '🍀',
      'color': Colors.green,
      'count': 4,
    },
    {
      'number': '5',
      'word': 'Five',
      'items': '✋',
      'color': Colors.orange,
      'count': 5,
    },
    {
      'number': '6',
      'word': 'Six',
      'items': '🎲',
      'color': Colors.purple,
      'count': 6,
    },
    {
      'number': '7',
      'word': 'Seven',
      'items': '🌈',
      'color': Colors.indigo,
      'count': 7,
    },
    {
      'number': '8',
      'word': 'Eight',
      'items': '🕷️',
      'color': Colors.teal,
      'count': 8,
    },
    {
      'number': '9',
      'word': 'Nine',
      'items': '⚾',
      'color': Colors.brown,
      'count': 9,
    },
    {
      'number': '10',
      'word': 'Ten',
      'items': '🤲',
      'color': Colors.pink,
      'count': 10,
    },
  ];

  @override
  void initState() {
    super.initState();
    _setupTts();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  void _setupTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setVolume(1.0);
    await flutterTts.setPitch(1.1);
  }

  void _speakNumber(String number, String word, int count) async {
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Count from 1 to the number
    String countingText = "";
    for (int i = 1; i <= count; i++) {
      countingText += "$i, ";
    }
    countingText = countingText.substring(
      0,
      countingText.length - 2,
    ); // Remove last comma

    await flutterTts.speak("$number. $word. Let's count: $countingText");
  }

  Widget _buildCountingDots(int count, Color color) {
    List<Widget> dots = [];
    const int maxDotsPerRow = 5;

    for (int i = 0; i < count; i++) {
      if (i > 0 && i % maxDotsPerRow == 0) {
        dots.add(const SizedBox(width: double.infinity, height: 4));
      }
      dots.add(
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      );
    }

    return Wrap(alignment: WrapAlignment.center, children: dots);
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
          '🔢 Learn Numbers',
          style: GoogleFonts.comicNeue(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFFFA709A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFA709A), Color(0xFFFEE140)],
          ),
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            final numberData = numbers[index];
            return AnimatedBuilder(
              animation: _bounceAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _bounceAnimation.value,
                  child: GestureDetector(
                    onTap:
                        () => _speakNumber(
                          numberData['number'],
                          numberData['word'],
                          numberData['count'],
                        ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: numberData['color'].withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Number
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: numberData['color'],
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: numberData['color'].withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                numberData['number'],
                                style: GoogleFonts.comicNeue(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Emoji representation
                          Text(
                            numberData['items'],
                            style: const TextStyle(fontSize: 24),
                          ),

                          const SizedBox(height: 8),

                          // Word
                          Text(
                            numberData['word'],
                            style: GoogleFonts.comicNeue(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: numberData['color'],
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Counting dots
                          _buildCountingDots(
                            numberData['count'],
                            numberData['color'],
                          ),

                          const SizedBox(height: 8),

                          // Sound icon
                          Icon(
                            Icons.volume_up,
                            color: numberData['color'].withOpacity(0.7),
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
          await flutterTts.speak("Tap any number to hear counting and learn!");
        },
        backgroundColor: const Color(0xFF6B73FF),
        child: const Icon(Icons.help_outline, color: Colors.white),
      ),
    );
  }
}
