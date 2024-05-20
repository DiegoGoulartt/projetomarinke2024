import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductService extends ChangeNotifier {
  final Map<String, int> _productQuantities = {};
  List<String> palletItems = [];

  Map<String, int> get productQuantities => _productQuantities;

  void selectProductForPallet(String product) {
    if (!_productQuantities.containsKey(product)) {
      _productQuantities[product] = 1;
    } else {
      _productQuantities[product] = _productQuantities[product]! + 1;
    }
    notifyListeners();
  }

  void addProductToPallet(String product) {
    if (product.isNotEmpty) {
      palletItems.add(product);
    }
    notifyListeners();
  }

  void decreaseQuantity(String product) {
    if (_productQuantities.containsKey(product) && _productQuantities[product]! > 0) {
      _productQuantities[product] = _productQuantities[product]! - 1;
      notifyListeners();
    }
  }

  void increaseQuantity(String product) {
    if (_productQuantities.containsKey(product)) {
      _productQuantities[product] = _productQuantities[product]! + 1;
      notifyListeners();
    }
  }

  String? selectedProductForPallet;

  getProductById(String product) {}

  void selectProductForComparison(String value) {}
}

class ProductDropdown extends StatefulWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final ProductService productService;

  const ProductDropdown({
    super.key,
    required this.label,
    required this.onChanged,
    required this.productService, required products,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductDropdownState createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  String? _selectedProduct;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedProduct,
      items: widget.productService.productQuantities.keys
          .map((product) => DropdownMenuItem<String>(
                value: product,
                child: Text(product),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedProduct = value;
        });
        widget.onChanged(value!);
      },
      hint: Text(widget.label),
    );
  }
}

class ProductQuantity extends StatefulWidget {
  final String product;

  const ProductQuantity({
    super.key,
    required this.product, required Null Function(dynamic quantity) onQuantityChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductQuantityState createState() => _ProductQuantityState();
}

class _ProductQuantityState extends State<ProductQuantity> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    final productService = Provider.of<ProductService>(context, listen: false);
    _quantity = productService.productQuantities[widget.product] ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            productService.decreaseQuantity(widget.product);
            setState(() {
              _quantity = productService.productQuantities[widget.product]!;
            });
          },
          child: const Icon(Icons.remove),
        ),
        Text('$_quantity'),
        ElevatedButton(
          onPressed: () {
            productService.increaseQuantity(widget.product);
            setState(() {
              _quantity = productService.productQuantities[widget.product]!;
            });
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}

class AddProductButton extends StatelessWidget {
  final ProductService productService;

  const AddProductButton({super.key, required this.productService});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final selectedProduct = productService.selectedProductForPallet;
        if (selectedProduct != null) {
          productService.addProductToPallet(selectedProduct);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectedProductsScreen(productService: productService),
            ),
          );
        }
      },
      child: const Text('Add Product'),
    );
  }
}

class SelectedProductsScreen extends StatelessWidget {
  final ProductService productService;

  const SelectedProductsScreen({super.key, required this.productService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Products'),
      ),
      body: ListView(
        children: productService.palletItems.map((product) => ListTile(title: Text(product))).toList(),
      ),
    );
  }
}

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
      home: Scaffold(
        appBar: AppBar(title: const Text('Product App')),
        body: Column(
          children: [
            Consumer<ProductService>(
              builder: (context, productService, child) {
                return ProductDropdown(
                  label: 'Select Product',
                  onChanged: (product) {
                    productService.selectedProductForPallet = product;
                  },
                  productService: productService, products: null,
                );
              },
            ),
            Consumer<ProductService>(
              builder: (context, productService, child) {
                return AddProductButton(productService: productService);
              },
            ),
          ],
        ),
      ),
    );
  }
}
