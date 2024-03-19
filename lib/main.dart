import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String output = "0";
  List<String> _board = List.filled(9, '');
  bool _isPlayerXTurn = true;
  String _winner = '';

  void checkWinner(String currentPlayer) {
    final List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (final pattern in winPatterns) {
      final a = pattern[0];
      final b = pattern[1];
      final c = pattern[2];

      if (_board[a] != '' && _board[a] == _board[b] && _board[a] == _board[c]) {
        _winner = currentPlayer;

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Winner'),
              content: Text('The winner is $_winner!'),
            );
          },
        );

        _board = List.filled(9, '');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: _board.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (_board[index] == '') {
                setState(() {
                  _board[index] = _isPlayerXTurn ? 'X' : 'O';
                  _isPlayerXTurn = !_isPlayerXTurn;
                });
                // Check for winner or draw
                checkWinner(_board[index]);
                // Implement game logic here
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: Center(
                child: Text(
                  _board[index],
                  style: TextStyle(fontSize: 32.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
