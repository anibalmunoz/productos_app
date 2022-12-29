import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/utils/app_color.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            CardContainer(
                child: Column(
              children: [
                const SizedBox(height: 10),
                Text("Login", style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 30),
                _LoginForm()
              ],
            )),
            const SizedBox(height: 50),
            const Text("Crear una nueva cuenta", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
              hintText: "john.doe@gmail.com", labelText: "Correo electrónico", prefixIcon: Icons.alternate_email_sharp),
        ),
        const SizedBox(height: 30),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecorations.authInputDecoration(
              hintText: "*****", labelText: "Contraseña", prefixIcon: Icons.lock_outline),
        ),
        const SizedBox(height: 30),
        MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.grey,
          elevation: 0,
          color: AppColor.primaryColor,
          onPressed: () {},
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: const Text(
                "Ingresar",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    ));
  }
}