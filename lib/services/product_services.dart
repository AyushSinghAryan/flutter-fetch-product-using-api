import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product_search_app/models/product_model.dart';

class ProductServices extends ChangeNotifier {
  static List<Product> products = [];
  static List<Product> filteredProducts = [];

  List<Product> userCart = [];

  Future<void> fetchProduct() async {
    final response = await http
        .get(Uri.parse("https://fakestoreapiserver.reactbd.com/products"));

    if (response.statusCode == 200) {
      final List<dynamic> productData = json.decode(response.body);
      products = productData.map((data) => Product.fromJson(data)).toList();
      filteredProducts = products;

      print(products.toString());
    } else {
      throw Exception("Faild to load products");
    }
  }

  List<Product> getProductList() {
    return userCart;
  }

  void addItemToCart(Product product) {
    userCart.add(product);
    notifyListeners();
  }

  void removeItemToCart(Product product) {
    userCart.remove(product);
    notifyListeners();
  }
}
