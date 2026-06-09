// Data model for products

import 'package:flutter/material.dart';

class Product {
  final String name;       
  final double price;      
  final String spec;       
  final IconData icon;    

  const Product({
    required this.name,
    required this.price,
    required this.spec,
    required this.icon,
  });
}

