import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unifrios_projeto/produto_dropdown.dart';

class SelectProductScreen extends StatelessWidget {
  const SelectProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the selected products from the `ProductService`
    final productService = Provider.of<ProductService>(context, listen: false);
    final selectedProducts = productService.palletItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Products'),
      ),
      body: ListView.builder(
        itemCount: selectedProducts.length,
        itemBuilder: (context, index) {
          final product = selectedProducts[index];
          // convert the product string to a Product object
          final productObject = productService.getProductById(product);
          return ListTile(
            title: Text(productObject.name),
            subtitle: Text('${productObject.quantity} x'),
          );
        },
      ),
    );
  }
}