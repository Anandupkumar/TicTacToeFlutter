import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

class MyBoardPage extends StatefulWidget {
  final String title;
  final String username;

  // const MyBoardPage({super.key, required this.title, required this.username});
  const MyBoardPage({super.key, required this.title, required this.username});

  @override
  State<MyBoardPage> createState() => _MyBoardPageState();
}

class _MyBoardPageState extends State<MyBoardPage> {
  // String output = "0";
  List<String> _board = List.filled(9, '');
  bool _isPlayerXTurn = true;
  String _winner = '';

  // final database = FirebaseDatabase.instance;

  void checkWinner(String currentPlayer) {
    // print(database);
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
        setState(() {
          _winner = currentPlayer;
        });

        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: const Text('Winner'),
        //       content: Text('The winner is $_winner!'),
        //     );
        //   },
        // );
      }
    }
  }

  void resetBoard() {
    setState(() {
      _board = List.filled(9, '');
      _winner = '';
    });
  }

  @override
  Widget build(BuildContext context) {

    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Check if args is not null before accessing its values
    final String username = args?['username'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
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
                              style: const TextStyle(fontSize: 30.0),
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: _board.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _winner != ''
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'The Winner is $_winner',
                                style: const TextStyle(fontSize: 20.0),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(20.0),
                                child: TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                  ),
                                  onPressed: () {
                                    resetBoard();
                                  },
                                  child: const Text('Reset'),
                                )),
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
