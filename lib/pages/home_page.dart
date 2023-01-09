import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/pages/pages.dart';
import 'package:productos_app/services/product_service.dart';
import 'package:productos_app/utils/app_color.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = "home";

  @override
  Widget build(BuildContext context) {
    final prodProvider = Provider.of<ProductService>(context);

    if (prodProvider.isLoading) return const LoadingPage();

    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),
      body: RefreshIndicator(
        color: AppColor.accentColor,
        onRefresh: () => prodProvider.onRefresh(),
        child: ListView.builder(
          itemCount: prodProvider.products.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              prodProvider.selectedProduct = prodProvider.products[index].copy();
              Navigator.pushNamed(context, ProductPage.routeName);
            },
            child: ProductCard(product: prodProvider.products[index]),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            prodProvider.selectedProduct = Product(available: true, name: "", price: 0.0);
            Navigator.pushNamed(context, ProductPage.routeName);
          },
          child: const Icon(Icons.add)),
    );
  }
}
