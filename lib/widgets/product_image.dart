import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: const ClipRRect(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: FadeInImage(
              placeholder: AssetImage("assets/jar-loading.gif"),
              image: NetworkImage("https://via.placeholder.com/400x300"),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.red,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))],
      );
}
