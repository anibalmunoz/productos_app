import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/product_service.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/utils/app_color.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  static const String routeName = "productos";

  @override
  Widget build(BuildContext context) {
    final prodService = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (context) => ProductFormProvider(product: prodService.selectedProduct!),
      child: _ProductPageBody(prodService: prodService),
    );
  }
}

class _ProductPageBody extends StatelessWidget {
  const _ProductPageBody({
    Key? key,
    required this.prodService,
  }) : super(key: key);

  final ProductService prodService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Column(
          children: [
            Stack(children: [
              ProductImage(urlimage: prodService.selectedProduct!.picture),
              Positioned(
                top: 60,
                left: 20,
                child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 40, color: Colors.white)),
              ),
              Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white),
                  ))
            ]),
            _ProductForm(),
            const SizedBox(height: 100)
          ],
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!productForm.isValidForm()) return;
            FocusScope.of(context).unfocus();
            await prodService.saveOrCreateProduct(productForm.product);
          },
          child: const Icon(Icons.save_outlined),
        ),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _builBoxDecoration(),
        child: Form(
            key: productForm.formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: productForm.nameController,
                  decoration:
                      InputDecorations.authInputDecoration(hintText: "Nombre del producto", labelText: "Nombre:"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "El nombre es obligatorio";
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: productForm.priceController,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))],
                  decoration: InputDecorations.authInputDecoration(hintText: "\$150.00", labelText: "Precio:"),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                SwitchListTile.adaptive(
                  value: product.available,
                  title: const Text("Disponible"),
                  activeColor: AppColor.accentColor,
                  onChanged: (value) => productForm.updateAvailable(value),
                ),
                const SizedBox(height: 30),
              ],
            )),
      ),
    );
  }

  BoxDecoration _builBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, 5), blurRadius: 5)],
      );
}
