import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final List<String> images;
  final String category;
  final String carBrand;
  final String carModel;
  final int carYear;
  final int stock;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.images,
    required this.category,
    required this.carBrand,
    required this.carModel,
    required this.carYear,
    required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'images': images,
      'category': category,
      'carBrand': carBrand,
      'carModel': carModel,
      'carYear': carYear,
      'stock': stock,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      carBrand: map['carBrand'] ?? '',
      carModel: map['carModel'] ?? '',
      carYear: map['carYear']?.toInt() ?? 0,
      stock: map['stock']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  get id => null;
}
