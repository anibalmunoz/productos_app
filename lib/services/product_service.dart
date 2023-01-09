import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/utils/app_config.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = "flutter-varios-83121-default-rtdb.firebaseio.com";
  final List<Product> products = [];
  bool isLoading = true;
  bool isSaving = false;
  Product? selectedProduct;
  File? newPictureFile;
  final storage = const FlutterSecureStorage();

  ProductService() {
    loadProductos();
  }

  Future<List<Product>> loadProductos() async {
    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, "products.json", {"auth": await storage.read(key: AppConfig.idToken) ?? ""});
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
    final url =
        Uri.https(_baseUrl, "products/${product.id}.json", {"auth": await storage.read(key: AppConfig.idToken) ?? ""});
    final response = await http.put(url, body: product.toJson());
    final decodedData = response.body;
    final index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;
    return "";
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, "products.json", {"auth": await storage.read(key: AppConfig.idToken) ?? ""});
    final response = await http.post(url, body: product.toJson());
    final decodedData = jsonDecode(response.body);
    product.id = decodedData["name"];
    products.add(product);
    return "";
  }

  updateSelectedProductImage(String path) {
    selectedProduct!.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<void> onRefresh() async {
    products.clear();
    loadProductos();
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    isSaving = true;
    notifyListeners();
    final url = Uri.parse("https://api.cloudinary.com/v1_1/dm9wndsmj/image/upload?upload_preset=ml_default");
    final imageUploadRequest = http.MultipartRequest("POST", url);
    final file = await http.MultipartFile.fromPath("file", newPictureFile!.path);
    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final res = await http.Response.fromStream(streamResponse);
    if (res.statusCode != 200 && res.statusCode != 201) {
      debugPrint("Algo salió mal");
      debugPrint(res.body);
      return null;
    }
    newPictureFile = null;
    final decodedData = jsonDecode(res.body);
    return decodedData["secure_url"];
  }
}
