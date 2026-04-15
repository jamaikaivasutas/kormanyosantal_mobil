import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MinesweeperApp());
}

class MinesweeperApp extends StatelessWidget {
  const MinesweeperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minesweeper',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MinesweeperPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MinesweeperPage extends StatefulWidget {
  const MinesweeperPage({super.key});

  @override
  State<MinesweeperPage> createState() => _MinesweeperPageState();
}

class _MinesweeperPageState extends State<MinesweeperPage> {
  static const int rows = 12;
  static const int cols = 9;
  static const int totalMines = 15;

  late List<List<Cell>> grid;
  bool isGameOver = false;
  bool isGameWon = false;
  int flagsPlaced = 0;
  int timerSeconds = 0;
  Timer? timer;
  int? bestTime;
  bool isFirstClick = true;

  @override
  void initState() {
    super.initState();
    _initializeGrid();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _initializeGrid() {
    timer?.cancel();
    isGameOver = false;
    isGameWon = false;
    flagsPlaced = 0;
    timerSeconds = 0;
    isFirstClick = true;

    // Create empty grid
    grid = List.generate(
      rows,
      (y) => List.generate(cols, (x) => Cell(x: x, y: y)),
    );

    setState(() {});
  }

  void _placeMines(int firstClickX, int firstClickY) {
    int minesPlaced = 0;
    final random = Random();

    while (minesPlaced < totalMines) {
      int rx = random.nextInt(cols);
      int ry = random.nextInt(rows);

      // Don't place mine on first click or if already a mine
      if ((rx == firstClickX && ry == firstClickY) || grid[ry][rx].isMine) {
        continue;
      }

      grid[ry][rx].isMine = true;
      minesPlaced++;
    }

    // Calculate neighboring mines
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if (!grid[y][x].isMine) {
          int count = 0;
          for (int dy = -1; dy <= 1; dy++) {
            for (int dx = -1; dx <= 1; dx++) {
              if (dy == 0 && dx == 0) continue;
              int ny = y + dy;
              int nx = x + dx;
              if (ny >= 0 && ny < rows && nx >= 0 && nx < cols) {
                if (grid[ny][nx].isMine) {
                  count++;
                }
              }
            }
          }
          grid[y][x].neighborMines = count;
        }
      }
    }

    // Start timer
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        timerSeconds++;
      });
    });
  }

  void _revealCell(Cell cell) {
    if (isGameOver || isGameWon || cell.isRevealed || cell.isFlagged) return;

    if (isFirstClick) {
      isFirstClick = false;
      _placeMines(cell.x, cell.y);
    }

    setState(() {
      cell.isRevealed = true;

      if (cell.isMine) {
        _handleGameOver();
        return;
      }

      if (cell.neighborMines == 0) {
        _revealNeighbors(cell);
      }

      _checkWinCondition();
    });
  }

  void _revealNeighbors(Cell cell) {
    for (int dy = -1; dy <= 1; dy++) {
      for (int dx = -1; dx <= 1; dx++) {
        if (dy == 0 && dx == 0) continue;
        int ny = cell.y + dy;
        int nx = cell.x + dx;
        if (ny >= 0 && ny < rows && nx >= 0 && nx < cols) {
          Cell neighbor = grid[ny][nx];
          if (!neighbor.isRevealed && !neighbor.isFlagged) {
            neighbor.isRevealed = true;
            if (neighbor.neighborMines == 0) {
              _revealNeighbors(neighbor);
            }
          }
        }
      }
    }
  }

  void _toggleFlag(Cell cell) {
    if (isGameOver || isGameWon || cell.isRevealed) return;

    setState(() {
      cell.isFlagged = !cell.isFlagged;
      flagsPlaced += cell.isFlagged ? 1 : -1;
    });
  }

  void _handleGameOver() {
    isGameOver = true;
    timer?.cancel();
    // Reveal all mines
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if (grid[y][x].isMine) {
          grid[y][x].isRevealed = true;
        }
      }
    }
  }

  void _checkWinCondition() {
    int revealedCount = 0;
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if (grid[y][x].isRevealed) {
          revealedCount++;
        }
      }
    }

    if (revealedCount == (rows * cols) - totalMines) {
      isGameWon = true;
      timer?.cancel();
      if (bestTime == null || timerSeconds < bestTime!) {
        bestTime = timerSeconds;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minesweeper'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _initializeGrid();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mines: ${totalMines - flagsPlaced}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Time: $timerSeconds',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Best: ${bestTime ?? "None"}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          if (isGameOver)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Game Over!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (isGameWon)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'You Win!',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 2.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AspectRatio(
                    aspectRatio: cols / rows,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cols,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                      ),
                      itemCount: rows * cols,
                      itemBuilder: (context, index) {
                        int x = index % cols;
                        int y = index ~/ cols;
                        return _buildCell(grid[y][x]);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(Cell cell) {
    return GestureDetector(
      onTap: () => _revealCell(cell),
      onSecondaryTap: () => _toggleFlag(cell),
      onLongPress: () => _toggleFlag(cell),
      child: Container(
        decoration: BoxDecoration(
          color: cell.isRevealed
              ? (cell.isMine ? Colors.red : Colors.grey[800])
              : Colors.grey[600],
          border: Border.all(color: Colors.grey[900]!),
        ),
        child: Center(child: _buildCellContent(cell)),
      ),
    );
  }

  Widget? _buildCellContent(Cell cell) {
    if (cell.isRevealed) {
      if (cell.isMine) {
        return const Icon(Icons.warning, size: 16, color: Colors.black);
      } else if (cell.neighborMines > 0) {
        return Text(
          cell.neighborMines.toString(),
          style: TextStyle(
            color: _getNumberColor(cell.neighborMines),
            fontWeight: FontWeight.bold,
          ),
        );
      }
    } else if (cell.isFlagged) {
      return const Icon(Icons.flag, size: 16, color: Colors.redAccent);
    }
    return null;
  }

  Color _getNumberColor(int count) {
    switch (count) {
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      case 4:
        return Colors.purple;
      case 5:
        return Colors.orange;
      case 6:
        return Colors.teal;
      case 7:
        return Colors.pink;
      case 8:
        return Colors.yellow;
      default:
        return Colors.white;
    }
  }
}

class Cell {
  final int x;
  final int y;
  bool isMine;
  bool isRevealed;
  bool isFlagged;
  int neighborMines;

  Cell({
    required this.x,
    required this.y,
    this.isMine = false,
    this.isRevealed = false,
    this.isFlagged = false,
    this.neighborMines = 0,
  });
}
