// UI Screen

import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/add_to_cart_dialog.dart';
import '../widgets/delete_dialog.dart';

// main display view
class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final List<Product> _cartItems = [];

  // catalog
  final List<Product> _products = const [
    Product(name: 'Wireless Headphones', price: 99.00, spec: 'Color: Matte Black', icon: Icons.headphones),
    Product(name: 'Smart Watch Series 9', price: 299.00, spec: 'Size: 45mm', icon: Icons.watch),
    Product(name: 'USB-C Fast Charger', price: 25.00, spec: 'Power: 45W', icon: Icons.battery_charging_full),
    Product(name: 'Bluetooth Speaker', price: 79.00, spec: '10W Output', icon: Icons.volume_up),
    Product(name: 'Laptop Stand', price: 45.00, spec: 'Aluminum', icon: Icons.laptop),
  ];

  // total price of cart items
  double _calculateTotal() {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }
  
  // trigger add to cart dialog
  void _triggerAddToCart(Product product) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AddToCartDialog(
        product: product,
        onConfirm: () {
          setState(() {
            _cartItems.add(product);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.name} added to cart!'),
              backgroundColor: Colors.deepPurple,
              duration: const Duration(seconds: 2),
            ),
          );
        },
      ),
    );
  }

  // trigger delete dialog
  void _triggerDelete(Product product, int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => DeleteDialog(
        itemName: product.name,
        onConfirm: () {
          setState(() {
            _cartItems.removeAt(index);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Your Cart', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          if (_cartItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.deepPurple.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${_cartItems.length} items in cart', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                      Text('Total: \$${_calculateTotal().toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: _cartItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart_outlined, size: 60, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text('Your cart is empty', style: TextStyle(fontSize: 16, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        color: Colors.white,
                        child: ListTile(
                          title: Text(item.name),
                          subtitle: Text(item.spec),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () => _triggerDelete(item, index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const Divider(height: 1),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16),
            child: const Text('Product Catalog (Tap to Add)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: Icon(product.icon, color: Colors.deepPurple),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)} - ${product.spec}'),
                    trailing: const Icon(Icons.add_shopping_cart, color: Colors.deepPurple),
                    onTap: () => _triggerAddToCart(product),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


