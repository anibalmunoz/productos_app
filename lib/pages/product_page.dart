import 'package:flutter/material.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  static const String routeName = "productos";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Stack(
            children: [
              ProductImage(),
            ],
          ),
        ],
      )),
    );
  }
}
