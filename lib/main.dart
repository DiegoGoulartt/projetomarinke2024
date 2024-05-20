import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unifrios_projeto/pallet.dart';
import 'package:unifrios_projeto/pallet2.dart';
import 'package:unifrios_projeto/produto_dropdown.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      routes: {
        '/pallet': (context) => const MyHomePage(),
        '/pallet2': (context) => const Pallet2(),
        '/productSelector': (context) => const ProductSelector(),
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenStateController createState() => _LoginScreenStateController();
}

class _LoginScreenStateController extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unifrios Login'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(0, 10),
              blurRadius: 1,
              color: Colors.blue,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Image(
                image: AssetImage('images/unifrios.png'),
              ),
            ),
            const SizedBox(height: 40),
            const Text('Usuário'),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Entre com seu Usuário',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Senha'),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Entre com sua Senha',
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                ),
              onPressed: () {
  if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill in all fields')),
    );
    return;
  }
  Navigator.pushNamed(context, '/pallet');
},
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}