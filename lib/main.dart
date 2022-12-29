import 'package:flutter/material.dart';
import 'package:productos_app/pages/pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      initialRoute: LoginPage.routeName,
      routes: {LoginPage.routeName: (context) => LoginPage(), HomePage.routeName: (context) => HomePage()},
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
    );
  }
}
