import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? urlimage;

  const ProductImage({super.key, this.urlimage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,
        child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
            child: getImage(urlimage)),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))],
      );

  Widget getImage(String? picture) {
    if (picture == null) {
      return const Image(
        image: AssetImage("assets/no-image.png"),
        fit: BoxFit.cover,
      );
    }

    if (picture.startsWith("http")) {
      return Opacity(
        opacity: 0.9,
        child: FadeInImage(
          placeholder: const AssetImage("assets/jar-loading.gif"),
          image: NetworkImage(urlimage!),
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.file(File(picture));
  }
}
