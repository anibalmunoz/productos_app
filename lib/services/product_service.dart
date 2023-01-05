import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;

class ProductService extends ChangeNotifier {
  final String _baseUrl = "flutter-varios-83121-default-rtdb.firebaseio.com";
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
  Product? selectedProduct;

  ProductService() {
    loadProductos();
  }

  Future<List<Product>> loadProductos() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, "products.json");
    final response = await http.get(url);
    final Map<String, dynamic> productsMap = jsonDecode(response.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });

    isLoading = false;
    notifyListeners();
    return products;
  }

  Future<void> saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      await createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product) async {
    final url = Uri.https(_baseUrl, "products/${product.id}.json");
    final response = await http.put(url, body: product.toJson());
    final decodedData = response.body;
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;
    return "";
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, "products/${product.id}.json");
    final response = await http.post(url, body: product.toJson());
    final decodedData = jsonDecode(response.body);
    product.id = decodedData["name"];
    products.add(product);
    return "";
  }
}
