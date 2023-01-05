import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/utils/app_color.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(alignment: Alignment.bottomLeft, children: [
          _BackgroundImage(urlImage: product.picture),
          _ProductDetails(id: product.id ?? "", name: product.name),
          Positioned(top: 0, right: 0, child: _PriceTag(price: product.price)),
          if (!product.available) Positioned(top: 0, left: 0, child: _NotAvailable())
        ]),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))]);
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), bottomRight: Radius.circular(25))),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "No disponible",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class _PriceTag extends StatelessWidget {
  final double price;

  const _PriceTag({required this.price});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: const BoxDecoration(
          color: AppColor.accentColor,
          borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25))),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text("\$$price", style: const TextStyle(color: Colors.white, fontSize: 20))),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  final String name;
  final String id;
  const _ProductDetails({required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _boxDecoration(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            name,
            style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            id,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ]),
      ),
    );
  }

  BoxDecoration _boxDecoration() => const BoxDecoration(
      color: AppColor.accentColor,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25)));
}

class _BackgroundImage extends StatelessWidget {
  final String? urlImage;

  const _BackgroundImage({this.urlImage});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: urlImage == null
            // ignore: prefer_const_constructors
            ? Image(image: AssetImage("assets/no-image.png"), fit: BoxFit.cover)
            : FadeInImage(
                fit: BoxFit.cover,
                placeholder: const AssetImage("assets/jar-loading.gif"),
                image: NetworkImage(urlImage!)),
      ),
    );
  }
}
