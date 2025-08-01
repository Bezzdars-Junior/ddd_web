import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '2048 Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Game2048(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Game2048 extends StatefulWidget {
  const Game2048({super.key});

  @override
  State<Game2048> createState() => _Game2048State();
}

class _Game2048State extends State<Game2048> {
  late List<List<int>> grid;
  int score = 0;
  int bestScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  void initGame() {
    grid = List.generate(4, (_) => List.filled(4, 0));
    score = 0;
    gameOver = false;
    addRandomTile();
    addRandomTile();
  }

  void addRandomTile() {
    List<Point<int>> emptyCells = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) {
          emptyCells.add(Point(i, j));
        }
      }
    }

    if (emptyCells.isNotEmpty) {
      final random = Random();
      final point = emptyCells[random.nextInt(emptyCells.length)];
      grid[point.x][point.y] = random.nextDouble() < 0.9 ? 2 : 4;
    }
  }

  bool canMove() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (grid[i][j] == 0) {
          return true;
        }
        if (i < 3 && grid[i][j] == grid[i + 1][j]) {
          return true;
        }
        if (j < 3 && grid[i][j] == grid[i][j + 1]) {
          return true;
        }
      }
    }
    return false;
  }

  void moveLeft() {
    bool moved = false;
    for (int i = 0; i < 4; i++) {
      List<int> row = grid[i].where((num) => num != 0).toList();
      List<int> newRow = [];

      for (int j = 0; j < row.length; j++) {
        if (j < row.length - 1 && row[j] == row[j + 1]) {
          int mergedValue = row[j] * 2;
          newRow.add(mergedValue);
          score += mergedValue;
          if (mergedValue == 2048) {
            _showWinDialog();
          }
          j++;
          moved = true;
        } else {
          newRow.add(row[j]);
        }
      }

      while (newRow.length < 4) {
        newRow.add(0);
      }

      if (!listEquals(grid[i], newRow)) {
        moved = true;
      }
      grid[i] = newRow;
    }

    if (moved) {
      addRandomTile();
      if (!canMove()) {
        gameOver = true;
        _showGameOverDialog();
      }
      setState(() {});
    }
  }

  void moveRight() {
    bool moved = false;
    for (int i = 0; i < 4; i++) {
      List<int> row = grid[i].where((num) => num != 0).toList();
      List<int> newRow = [];

      for (int j = row.length - 1; j >= 0; j--) {
        if (j > 0 && row[j] == row[j - 1]) {
          int mergedValue = row[j] * 2;
          newRow.insert(0, mergedValue);
          score += mergedValue;
          if (mergedValue == 2048) {
            _showWinDialog();
          }
          j--;
          moved = true;
        } else {
          newRow.insert(0, row[j]);
        }
      }

      while (newRow.length < 4) {
        newRow.insert(0, 0);
      }

      if (!listEquals(grid[i], newRow)) {
        moved = true;
      }
      grid[i] = newRow;
    }

    if (moved) {
      addRandomTile();
      if (!canMove()) {
        gameOver = true;
        _showGameOverDialog();
      }
      setState(() {});
    }
  }

  void moveUp() {
    bool moved = false;
    for (int j = 0; j < 4; j++) {
      List<int> column = [];
      for (int i = 0; i < 4; i++) {
        if (grid[i][j] != 0) {
          column.add(grid[i][j]);
        }
      }

      List<int> newColumn = [];
      for (int i = 0; i < column.length; i++) {
        if (i < column.length - 1 && column[i] == column[i + 1]) {
          int mergedValue = column[i] * 2;
          newColumn.add(mergedValue);
          score += mergedValue;
          if (mergedValue == 2048) {
            _showWinDialog();
          }
          i++;
          moved = true;
        } else {
          newColumn.add(column[i]);
        }
      }

      while (newColumn.length < 4) {
        newColumn.add(0);
      }

      for (int i = 0; i < 4; i++) {
        if (grid[i][j] != newColumn[i]) {
          moved = true;
        }
        grid[i][j] = newColumn[i];
      }
    }

    if (moved) {
      addRandomTile();
      if (!canMove()) {
        gameOver = true;
        _showGameOverDialog();
      }
      setState(() {});
    }
  }

  void moveDown() {
    bool moved = false;
    for (int j = 0; j < 4; j++) {
      List<int> column = [];
      for (int i = 0; i < 4; i++) {
        if (grid[i][j] != 0) {
          column.add(grid[i][j]);
        }
      }

      List<int> newColumn = [];
      for (int i = column.length - 1; i >= 0; i--) {
        if (i > 0 && column[i] == column[i - 1]) {
          int mergedValue = column[i] * 2;
          newColumn.insert(0, mergedValue);
          score += mergedValue;
          if (mergedValue == 2048) {
            _showWinDialog();
          }
          i--;
          moved = true;
        } else {
          newColumn.insert(0, column[i]);
        }
      }

      while (newColumn.length < 4) {
        newColumn.insert(0, 0);
      }

      for (int i = 0; i < 4; i++) {
        if (grid[i][j] != newColumn[i]) {
          moved = true;
        }
        grid[i][j] = newColumn[i];
      }
    }

    if (moved) {
      addRandomTile();
      if (!canMove()) {
        gameOver = true;
        _showGameOverDialog();
      }
      setState(() {});
    }
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over!'),
          content: Text('Your score: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                initGame();
                setState(() {});
              },
              child: const Text('Try Again'),
            ),
          ],
        );
      },
    );
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You Win!'),
          content: Text('Congratulations! You reached 2048!\nScore: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Continue'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                initGame();
                setState(() {});
              },
              child: const Text('New Game'),
            ),
          ],
        );
      },
    );
  }

  Color getTileColor(int value) {
    switch (value) {
      case 2:
        return Colors.orange[50]!;
      case 4:
        return Colors.orange[100]!;
      case 8:
        return Colors.orange[200]!;
      case 16:
        return Colors.orange[300]!;
      case 32:
        return Colors.orange[400]!;
      case 64:
        return Colors.orange[500]!;
      case 128:
        return Colors.orange[600]!;
      case 256:
        return Colors.orange[700]!;
      case 512:
        return Colors.orange[800]!;
      case 1024:
        return Colors.orange[900]!;
      case 2048:
        return Colors.deepOrange[900]!;
      default:
        return Colors.grey[300]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cellSize = (size.width - 40) / 4;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('2048 Game'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              initGame();
              setState(() {});
            },
          ),
        ],
      ),
      body: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'SCORE',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$score',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'BEST',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$bestScore',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  moveUp();
                } else if (details.primaryVelocity! > 0) {
                  moveDown();
                }
              },
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  moveLeft();
                } else if (details.primaryVelocity! > 0) {
                  moveRight();
                }
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SizedBox(
                  width: size.width,
                  height: size.width,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      int row = index ~/ 4;
                      int col = index % 4;
                      int value = grid[row][col];
                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: getTileColor(value),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: value != 0
                              ? Text(
                                  '$value',
                                  style: TextStyle(
                                    fontSize: cellSize * 0.3,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        value < 8 ? Colors.black : Colors.white,
                                  ),
                                )
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Swipe to move tiles',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              'Join the numbers to get to 2048!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
