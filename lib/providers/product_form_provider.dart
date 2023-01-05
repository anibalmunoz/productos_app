import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  Product product;

  ProductFormProvider({required this.product}) {
    igualarVariables();
  }
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
    product.name = nameController.text;

    return formkey.currentState?.validate() ?? false;
  }

  updateAvailable(bool value) {
    product.available = value;
    notifyListeners();
  }
}
