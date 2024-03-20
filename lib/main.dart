import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Replace with your actual Firebase project configuration
  const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyCfvCTqInEbYBGL9n8B6OlUd37o_ga43K4",
    authDomain: "https://crickclub-265cd-default-rtdb.firebaseio.com",
    projectId: "crickclub-265cd",
    storageBucket: "crickclub-265cd.appspot.com",
    messagingSenderId: "996731428183",
    appId: "1:996731428183:ios:3530fee402011cbe41b212",
  );

  await Firebase.initializeApp(options: firebaseConfig);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

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
  const MyHomePage({required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String output = "0";
  List<String> _board = List.filled(9, '');
  bool _isPlayerXTurn = true;
  String _winner = '';

  final database = FirebaseDatabase.instance;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
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
