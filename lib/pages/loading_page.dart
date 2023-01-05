import 'package:flutter/material.dart';
import 'package:productos_app/utils/app_color.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos"),
      ),
      body: const Center(child: CircularProgressIndicator(color: AppColor.accentColor)),
    );
  }
}
