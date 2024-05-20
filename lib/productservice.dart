import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unifrios_projeto/provider.dart';
// ignore: unused_import
import 'produto_dropdown.dart';

class ProductDropdownState extends ChangeNotifier {
  // Add your state variables and methods here
}

void main() {
  runApp(
    ChangeNotifierProvider<ProductDropdownState>(
      create: (_) => ProductDropdownState(),
      child: const MyApp(),
    ),
  );
}

class _ProductDropdownState with ChangeNotifier {
  Product? _selectedProductForPallet;
  final List<Product> _products = [];
  final List<String> _palletItems = [];

  Product? get selectedProductForPallet => _selectedProductForPallet;
  List<Product> get products => _products;
  List<String> get palletItems => _palletItems;

  void changeSelectedProduct(Product? value) {
    _selectedProductForPallet = value;
    notifyListeners();
  }

  List<DropdownMenuItem<Product>> getProductDropdownItems() {
    return _products.map<DropdownMenuItem<Product>>((product) {
      return DropdownMenuItem<Product>(
        value: product,
        child: Text(product.name),
      );
    }).toList();
  }

  void addProductToPallet(Product selectedProduct) {
    _palletItems.add(selectedProduct.name);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = context.watch<_ProductDropdownState>();
    // ...
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ações do Produto'),
      ),
      body: Column(
        children: [
          _ProductDropdown(productService),
          _AddProductButton(productService),
          _PalletActions(productService),
          _PalletItemList(productService),
        ],
      ),
    );
  }
}

class _ProductDropdown extends StatelessWidget {
  final _ProductDropdownState productService;

  const _ProductDropdown(this.productService);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Product>(
      value: productService.selectedProductForPallet,
      onChanged: (Product? value) {
        productService.changeSelectedProduct(value);
      },
      items: productService.getProductDropdownItems(),
    );
  }
}

class _AddProductButton extends StatelessWidget {
  final _ProductDropdownState productService;

  const _AddProductButton(this.productService);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final selectedProduct = productService.selectedProductForPallet;
        if (selectedProduct != null) {
          productService.addProductToPallet(selectedProduct);
        }
      },
      child: const Text('Adicionar Produto'),
    );
  }
}

class _PalletActions extends StatelessWidget {
  final _ProductDropdownState productService;

  const _PalletActions(this.productService);

  @override
  Widget build(BuildContext context) {
    return Container(); // Implementar de acordo com a sua necessidade
  }
}

class _PalletItemList extends StatelessWidget {
  final _ProductDropdownState productService;

  const _PalletItemList(this.productService);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: productService.palletItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(productService.palletItems[index]),
          );
        },
      ),
    );
  }
}