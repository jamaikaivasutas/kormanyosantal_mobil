import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Bird',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const FlappyBirdGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Pipe {
  double x;
  final double gapY;

  Pipe({required this.x, required this.gapY});
}

class FlappyBirdGame extends StatefulWidget {
  const FlappyBirdGame({super.key});

  @override
  State<FlappyBirdGame> createState() => _FlappyBirdGameState();
}

class _FlappyBirdGameState extends State<FlappyBirdGame>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double birdY = 0.3;
  double birdVelocity = 0.0;
  double gravity = 0.0002;
  double jumpPower = 0.035;
  bool isGameOver = false;
  bool gameStarted = false;
  int score = 0;
  late List<Pipe> pipes;
  double pipeDistance = 0.6;
  double pipeWidth = 0.1;
  final double birdSize = 0.06;
  final double birdX = 0.1;
  final double gapSize = 0.35;

  @override
  void initState() {
    super.initState();
    pipes = [];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(days: 1),
    );
    _animationController.addListener(_update);
    _generatePipes();
  }

  void _generatePipes() {
    pipes.clear();
    Random random = Random();
    for (int i = 0; i < 5; i++) {
      double pipeY = random.nextDouble() * 0.6 + 0.1;
      pipes.add(
        Pipe(x: pipeDistance + i * (pipeDistance + pipeWidth), gapY: pipeY),
      );
    }
  }

  void _update() {
    setState(() {
      birdVelocity += gravity;
      birdY += birdVelocity;

      // Check boundaries
      if (birdY <= 0 || birdY >= 1) {
        _gameOver();
        return;
      }

      // Update pipes
      for (var pipe in pipes) {
        pipe.x -= 0.008;
      }

      // Remove pipes that are off screen and add new ones
      if (pipes.isNotEmpty && pipes.first.x + pipeWidth < 0) {
        pipes.removeAt(0);
        Random random = Random();
        double pipeY = random.nextDouble() * 0.6 + 0.1;
        pipes.add(
          Pipe(
            x: pipeDistance + pipes.length * (pipeDistance + pipeWidth),
            gapY: pipeY,
          ),
        );
        score++;
      }

      // Check collision with pipes
      for (var pipe in pipes) {
        if (birdX + birdSize > pipe.x &&
            birdX < pipe.x + pipeWidth &&
            (birdY < pipe.gapY || birdY + birdSize > pipe.gapY + gapSize)) {
          _gameOver();
        }
      }
    });
  }

  void _gameOver() {
    if (!isGameOver) {
      isGameOver = true;
      _animationController.stop();
    }
  }

  void _tap() {
    if (!gameStarted) {
      return; // Don't allow jumping on title screen
    }
    if (!isGameOver) {
      birdVelocity = -jumpPower;
    }
  }

  void _startGame() {
    setState(() {
      gameStarted = true;
      _animationController.forward();
    });
  }

  void _restart() {
    setState(() {
      birdY = 0.3;
      birdVelocity = 0.0;
      isGameOver = false;
      gameStarted = false;
      score = 0;
      _generatePipes();
      _animationController.stop();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show title screen if game hasn't started
    if (!gameStarted) {
      return Scaffold(
        body: Container(
          color: Colors.lightBlue[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Flappy Bird',
                  style: TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 3,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange, width: 3),
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 20,
                    ),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text(
                    'Play',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Game screen
    return Scaffold(
      body: GestureDetector(
        onTap: _tap,
        child: Container(
          color: Colors.lightBlue[200],
          child: Stack(
            children: [
              // Pipes
              ...pipes.map((pipe) {
                double screenWidth = MediaQuery.of(context).size.width;
                double screenHeight = MediaQuery.of(context).size.height;
                double pipePixelWidth = pipeWidth * screenWidth;
                double gapPixelSize = gapSize * screenHeight;
                double gapPixelY = pipe.gapY * screenHeight;

                return Stack(
                  children: [
                    // Top pipe
                    Positioned(
                      left: pipe.x * screenWidth,
                      top: 0,
                      child: Container(
                        width: pipePixelWidth,
                        height: gapPixelY,
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          border: Border.all(
                            color: Colors.green[900]!,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    // Bottom pipe
                    Positioned(
                      left: pipe.x * screenWidth,
                      top: gapPixelY + gapPixelSize,
                      child: Container(
                        width: pipePixelWidth,
                        height: screenHeight - (gapPixelY + gapPixelSize),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          border: Border.all(
                            color: Colors.green[900]!,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
              // Bird
              Positioned(
                left: birdX * MediaQuery.of(context).size.width,
                top: birdY * MediaQuery.of(context).size.height,
                child: Container(
                  width: birdSize * MediaQuery.of(context).size.width,
                  height: birdSize * MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                ),
              ),
              // Score
              Positioned(
                top: 50,
                left: 20,
                child: Text(
                  'Score: $score',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 3,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              // Game Over screen
              if (isGameOver)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Game Over',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Final Score: $score',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: _restart,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 15,
                                ),
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Restart',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
