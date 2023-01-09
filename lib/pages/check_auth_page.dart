import 'package:flutter/material.dart';
import 'package:productos_app/pages/pages.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthPage extends StatelessWidget {
  const CheckAuthPage({Key? key}) : super(key: key);

  static const String routeName = "checking";

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: authService.isAuthenticated(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();
          if (snapshot.data == "") {
            Future.microtask(() {
              //Navigator.pushReplacementNamed(context, LoginPage.routeName);
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
            });
          } else {
            Future.microtask(() {
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
                  transitionDuration: const Duration(seconds: 0),
                ),
              );
            });
          }
          return Container();
        },
      ),
    );
  }
}
