// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  num id;
  String title;
  bool isNew;
  String oldPrice;
  num price;
  String description;
  String category;
  String image;
  num rating;

  Product({
    required this.id,
    required this.title,
    required this.isNew,
    required this.oldPrice,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        title: json["title"],
        isNew: json["isNew"],
        oldPrice: json["oldPrice"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "isNew": isNew,
        "oldPrice": oldPrice,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating,
      };
}
