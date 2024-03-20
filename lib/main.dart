import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Replace with your actual Firebase project configuration
  const firebaseConfig = FirebaseOptions(
    apiKey: "fhhfdhdfhfgfjtruery",
    authDomain: "https://gdhgh-ththh-ht-tht.firebaseio.com",
    projectId: "ththt-265cd",
    storageBucket: "ththhth-hthth.ththth.com",
    messagingSenderId: "563453453543",
    appId: "1:gjj232gj21:ios:5434553gjfgj",
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
      routes: {
        '/home': (context) => const MyHomePage(
            title: 'Tic Tac Toe'), // Default route to the home page
        '/': (context) => LoginPage(), // Route to the login page
      },
      // home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final database = FirebaseDatabase.instance;
  // Access database in initState
  late final gameRef;

  @override
  void initState() {
    super.initState();
    gameRef =
        database.ref('game'); // Initialize gameRef after database is ready
  }

  final TextEditingController _usernameController = TextEditingController();

  void doLogin(BuildContext context, username) {
    print(gameRef);
    if (username != '') {
      Navigator.pushNamed(context, '/home');
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
