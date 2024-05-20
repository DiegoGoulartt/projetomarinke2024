import 'package:flutter/material.dart';

class ProductSelector extends StatefulWidget {
  const ProductSelector({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductSelectorState createState() => _ProductSelectorState();
}

class _ProductSelectorState extends State<ProductSelector> {
  final _formKey = GlobalKey<FormState>();
  final idRomaneioController = TextEditingController();
  final nomeClienteController = TextEditingController();

  @override
  void dispose() {
    idRomaneioController.dispose();
    nomeClienteController.dispose();
    super.dispose();
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
                offset: Offset(0, 1),
                blurRadius: 1,
                color: Color.fromARGB(255, 4, 140, 252),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              TextFormField(
                controller: idRomaneioController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the id romaneio';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('ID Romaneio'),
                  hintText: 'Enter ID Romaneio',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: nomeClienteController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Nome cliente';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text('Nome Cliente'),
                  hintText: 'Enter Nome Cliente',
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Processando Informações')));
                      Navigator.pushNamed(context, '/pallet');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text('Próximo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}