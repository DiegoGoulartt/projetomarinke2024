import 'package:flutter/material.dart';
import 'package:unifrios_projeto/produto_dropdown.dart';

// ignore: unused_import
import 'productservice.dart';

// ignore: unused_element
class PalletItemList extends StatelessWidget {
  final List<String> palletItems;
  final Function(String) onProductRemoved;

  const PalletItemList({super.key, required this.palletItems, required this.onProductRemoved});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: palletItems.length,
      itemBuilder: (context, index) {
        final product = palletItems[index];
        return ListTile(
          title: Text(product),
          trailing: ProductQuantity(
            product: product,
            onQuantityChanged: (quantity) {
              if (quantity == 0) {
                onProductRemoved(product);
              }
            },
          ),
        );
      },
    );
  }
}

// ignore: unused_element
class _PalletActions extends StatelessWidget {
  final ProductService productService;

  // ignore: unused_element
  const _PalletActions(this.productService, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AddProductButton(productService: productService),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            productService.palletItems.clear();
          },
          child: const Text('Clear Pallet'),
        ),
      ],
    );
  }
  
  // ignore: non_constant_identifier_names
  _AddProductButton({required ProductService productService}) {}
}