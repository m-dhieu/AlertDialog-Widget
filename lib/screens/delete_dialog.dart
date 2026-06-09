// Method for item removal from cart

import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final String itemName;              
  final VoidCallback onConfirm;       

  const DeleteDialog({
    super.key,
    required this.itemName,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // bold warning header
      title: Text('Remove $itemName?'),
      
      // confirmation message
      content: const Text('Are you sure you want to remove this item from your cart?'),

      // user confirmation buttons
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.shade600, 
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            onConfirm();                 
            Navigator.of(context).pop();  
          },
          child: const Text('Remove'),
        ),
      ],
    );
  }
}

