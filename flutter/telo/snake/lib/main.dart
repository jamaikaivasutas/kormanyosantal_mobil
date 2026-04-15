import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const SnakeGame());
}

enum Direction {
  up(Offset(0, -1)),
  down(Offset(0, 1)),
  left(Offset(-1, 0)),
  right(Offset(1, 0));

  final Offset offset;
  const Direction(this.offset);
}

class SnakeGame extends StatelessWidget {
  const SnakeGame({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake Game',
      theme: ThemeData(useMaterial3: true),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int gridSize = 20;
  late List<Offset> snake;
  late Offset food;
  late Direction direction;
  late Direction nextDirection;
  late Timer gameTimer;
  bool isGameOver = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    snake = [const Offset(10, 10), const Offset(9, 10), const Offset(8, 10)];
    direction = Direction.right;
    nextDirection = Direction.right;
    score = 0;
    isGameOver = false;
    generateFood();
    startGameLoop();
  }

  void generateFood() {
    final random = Random();
    Offset newFood;
    do {
      newFood = Offset(
        random.nextInt(gridSize).toDouble(),
        random.nextInt(gridSize).toDouble(),
      );
    } while (snake.contains(newFood));
    food = newFood;
  }

  void startGameLoop() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 150), (_) {
      if (!isGameOver) {
        updateGame();
      }
    });
  }

  void updateGame() {
    direction = nextDirection;

    Offset head = snake[0];
    Offset newHead = Offset(
      (head.dx + direction.offset.dx) % gridSize,
      (head.dy + direction.offset.dy) % gridSize,
    );

    if (snake.sublist(1).contains(newHead)) {
      endGame();
      return;
    }

    snake.insert(0, newHead);

    if (newHead == food) {
      score += 10;
      generateFood();
    } else {
      snake.removeLast();
    }

    setState(() {});
  }

  void endGame() {
    isGameOver = true;
    gameTimer.cancel();
    setState(() {});
  }

  void resetGame() {
    gameTimer.cancel();
    setState(() {
      initializeGame();
    });
  }

  void changeDirection(Direction newDirection) {
    if (!isGameOver && !isOppositeDirection(direction, newDirection)) {
      nextDirection = newDirection;
    }
  }

  bool isOppositeDirection(Direction current, Direction next) {
    return (current == Direction.up && next == Direction.down) ||
        (current == Direction.down && next == Direction.up) ||
        (current == Direction.left && next == Direction.right) ||
        (current == Direction.right && next == Direction.left);
  }

  @override
  void dispose() {
    gameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Snake Game'),
        backgroundColor: Colors.black87,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (details.delta.dy < 0) {
                    changeDirection(Direction.up);
                  } else if (details.delta.dy > 0) {
                    changeDirection(Direction.down);
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx < 0) {
                    changeDirection(Direction.left);
                  } else if (details.delta.dx > 0) {
                    changeDirection(Direction.right);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: CustomPaint(
                    painter: GamePainter(
                      snake: snake,
                      food: food,
                      gridSize: gridSize,
                    ),
                    size: Size.square(MediaQuery.of(context).size.width - 32),
                  ),
                ),
              ),
            ),
          ),
          if (isGameOver)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Game Over!',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: resetGame,
                    child: const Text('Play Again'),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                'Swipe to control snake',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
        ],
      ),
    );
  }
}

class GamePainter extends CustomPainter {
  final List<Offset> snake;
  final Offset food;
  final int gridSize;

  GamePainter({
    required this.snake,
    required this.food,
    required this.gridSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cellWidth = size.width / gridSize;
    final cellHeight = size.height / gridSize;

    // Draw snake
    final snakePaint = Paint()..color = Colors.green;
    for (var segment in snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          segment.dx * cellWidth,
          segment.dy * cellHeight,
          cellWidth,
          cellHeight,
        ),
        snakePaint,
      );
    }

    // Draw food
    final foodPaint = Paint()..color = Colors.red;
    canvas.drawCircle(
      Offset(
        food.dx * cellWidth + cellWidth / 2,
        food.dy * cellHeight + cellHeight / 2,
      ),
      cellWidth / 2.5,
      foodPaint,
    );
  }

  @override
  bool shouldRepaint(GamePainter oldDelegate) => true;
}
