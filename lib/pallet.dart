import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:unifrios_projeto/repository/conexao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iniciar Carregamento',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
      ),
      home: const MyHomePage(),
      routes: {
        '/pallet2': (context) => const Pallet2(),
      },
    );
  }
}

class Pallet2 extends StatelessWidget {
  const Pallet2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pallet 2'),
      ),
      body: const Center(
        child: Text('Pallet 2'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _motoristaFormKey = GlobalKey<FormState>();
  final _veiculoFormKey = GlobalKey<FormState>();
  late Database _database;
  String? _motoristaValue;
  String? _veiculoValue;
  final _motoristaController = TextEditingController();
  final _veiculoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    PalletConexao.instance.database.then((database) {
      setState(() {
        _database = database;
      });
    }).whenComplete(() {
      // Any code you want to execute after the database has been initialized can go here.
    });
  }

  void _submitForm() async {
  if (_motoristaFormKey.currentState!.validate() && _veiculoFormKey.currentState!.validate()) {      
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processando Informações')));

      // Save the form data into the _motoristaValue and _veiculoValue variables
      _motoristaFormKey.currentState!.save();
      _veiculoFormKey.currentState!.save();

      // Insert the data into the database
      await _database.insert(
        PalletConexao.table,
        {'motorista': _motoristaValue, 'veiculo': _veiculoValue},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      // Clear the form fields
      _motoristaController.clear();
      _veiculoController.clear();

      // Reset the form keys
      _motoristaFormKey.currentState!.reset();
      _veiculoFormKey.currentState!.reset();

      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/pallet2');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Iniciar Carregamento',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 91, 249),
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Color.fromARGB(255, 0, 91, 249),
                blurRadius: 5.0,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                key: _motoristaFormKey,
                controller: _motoristaController,
                decoration: const InputDecoration(
                  labelText: 'Motorista',
                  hintText: 'Informe o motorista',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o motorista';
                  }
                  return null;
                },
                onSaved: (value) {
                  _motoristaValue = value;
                },
              ),
              TextFormField(
                key: _veiculoFormKey,
                controller: _veiculoController,
                decoration: const InputDecoration(
                  labelText: 'Veículo',
                  hintText: 'Informe o veículo',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o veículo';
                  }
                  return null;
                },
                onSaved: (value) {
                  _veiculoValue = value;
                },
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enviar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}