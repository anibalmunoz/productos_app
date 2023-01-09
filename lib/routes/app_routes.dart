import 'package:flutter/material.dart';
import 'package:productos_app/pages/pages.dart';

Map<String, WidgetBuilder> get getAppRoutes {
  return {
    LoginPage.routeName: (context) => const LoginPage(),
    HomePage.routeName: (context) => const HomePage(),
    ProductPage.routeName: (context) => const ProductPage(),
    RegisterPage.routeName: (context) => const RegisterPage(),
    CheckAuthPage.routeName: (context) => const CheckAuthPage()
  };
}
