import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'board.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      routes: {
        '/borad': (context) => const MyBoardPage(
            title: 'Tic Tac Toe',
            username: ''), // Default route to the home page
        '/': (context) => const LoginPage(), // Route to the login page
      },
      // home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();

  void doLogin(BuildContext context, username) {
    if (username.isNotEmpty) {
      Navigator.pushNamed(
        context,
        '/borad',
        arguments: {'username': username},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                doLogin(context, username);
                // Implement login logic here
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
