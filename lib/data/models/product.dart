import 'dart:convert';

class Product {
  final String name;
  final String description;
  final String price;
  final String image;
  final String id;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.id,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "image": image,
        "id": id,
      };
}
