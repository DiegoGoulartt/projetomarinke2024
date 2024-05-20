import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unifrios_projeto/produto_dropdown.dart';

class AddProductButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddProductButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Adicionar Produto'),
    );
  }
}

class PalletActions extends StatelessWidget {
  const PalletActions({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context, listen: false);
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            final selectedProduct = productService.selectedProductForPallet;
            if (selectedProduct != null) {
              productService.increaseQuantity(selectedProduct);
            }
          },
          child: const Text('Add Quantity'),
        ),
        ElevatedButton(
          onPressed: () {
            final selectedProduct = productService.selectedProductForPallet;
            if (selectedProduct != null) {
              productService.decreaseQuantity(selectedProduct);
            }
          },
          child: const Text('Remove Quantity'),
        ),
      ],
    );
  }
}