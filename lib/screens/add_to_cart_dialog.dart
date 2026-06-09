// Method to add item to cart

import 'package:flutter/material.dart';
import '../models/product_model.dart';

class AddToCartDialog extends StatelessWidget {
  final Product product;              
  final VoidCallback onConfirm;       

  const AddToCartDialog({
    super.key,
    required this.product,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // show large product name
      title: Text('Add ${product.name}?'),
      
      // show product details
      content: Text('Add \$${product.price.toStringAsFixed(2)} to your cart?'),
      
      // buttons to add to cart or cancel
      actions: <Widget>[
        // cancel button
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Cancel'),
        ),
        // add button
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple, 
            foregroundColor: Colors.white,      
          ),
          onPressed: () {
            onConfirm();                  
            Navigator.of(context).pop(); 
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
