import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import 'package:unifrios_projeto/produto_dropdown.dart';
// ignore: unused_import
import 'productservice.dart';

class ProductSelector extends StatefulWidget {
  const ProductSelector({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductSelectorState createState() => _ProductSelectorState();
}

class _ProductSelectorState extends State<ProductSelector> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Pallet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductSelectorBody(
          productService: _productService,
        ),
      ),
    );
  }
}

class ProductSelectorBody extends StatefulWidget {
  final ProductService productService;

  const ProductSelectorBody({super.key, required this.productService});

  @override
  // ignore: library_private_types_in_public_api
  _ProductSelectorBodyState createState() => _ProductSelectorBodyState();
}

class _ProductSelectorBodyState extends State<ProductSelectorBody> {
  late ProductService _productService;

  @override
  void initState() {
    super.initState();
    _productService = widget.productService;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ProductDropdown(
          label: 'Selecione o produto para pallet',
          onChanged: (value) {
            _productService.selectProductForPallet(value);
          },
          productService: _productService, products: null,
        ),
        ProductDropdown(
          label: 'Selecione o produto para comparação',
          onChanged: (value) {
            _productService.selectProductForComparison(value);
          },
          productService: _productService, products: null,
        ),
        AddProductButton(
          onPressed: () {
            _productService.addProductToPallet('');
          },
        ),
        const PalletActions(),
        Expanded(
          child: PalletItemList(
            palletItems: _productService.palletItems,
          ),
        ),
      ],
    );
  }
}

class AddProductButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddProductButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text('Adicionar produto'),
    );
  }
}

class PalletActions extends StatelessWidget {
  const PalletActions({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement pallet actions widget
    return Container();
  }
}

class PalletItemList extends StatelessWidget {
  final List<String> palletItems;

  const PalletItemList({super.key, required this.palletItems});

  @override
  Widget build(BuildContext context) {
    // Implement pallet item list widget
    return Container();
  }
}

// ... (rest of the code)