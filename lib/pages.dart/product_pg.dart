import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> products = [
    Product('Product 1', _generateUniqueId(), 100, DateTime.now()),
    Product(
        'Product 2', _generateUniqueId(), 200, DateTime.now().subtract(const Duration(days: 1))),
    Product(
        'Product 3', _generateUniqueId(), 150, DateTime.now().subtract(const Duration(days: 2))),
  ];

  static String _generateUniqueId() {
    return Random().nextInt(100000).toString().padLeft(5, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(product.productName),
              subtitle: Text('Price: ₹${product.price}'),
              trailing: Text('Added on: ${DateFormat('yyyy-MM-dd').format(product.dateAdded)}'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    final productNameController = TextEditingController();
    final priceController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date Added (YYYY-MM-DD)'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final productName = productNameController.text;
                final price = double.tryParse(priceController.text) ?? 0;
                final dateAdded = DateTime.tryParse(dateController.text) ?? DateTime.now();

                setState(() {
                  products.add(Product(productName, _generateUniqueId(), price, dateAdded));
                });

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

class Product {
  final String productName;
  final String uniqueId;
  final double price;
  final DateTime dateAdded;

  Product(this.productName, this.uniqueId, this.price, this.dateAdded);
}
