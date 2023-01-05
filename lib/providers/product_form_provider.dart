import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Product product;

  ProductFormProvider({required this.product}) {
    igualarVariables();
  }

  final nameController = TextEditingController();
  final priceController = TextEditingController();

  igualarVariables() {
    nameController.text = product.name;
    priceController.text = product.price.toString();
  }

  bool isValidForm() {
    if (double.tryParse(priceController.text) == null) {
      product.price = 0;
    } else {
      product.price = double.parse(priceController.text);
    }
    return formkey.currentState?.validate() ?? false;
  }

  updateAvailable(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }
}
