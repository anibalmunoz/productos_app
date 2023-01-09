import 'package:flutter/material.dart';
import 'package:productos_app/pages/pages.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/utils/app_color.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

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
                ChangeNotifierProvider(create: (context) => LoginFormProvider(), child: _LoginForm())
              ],
            )),
            const SizedBox(height: 50),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, RegisterPage.routeName),
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())),
              child: const Text("Crear una nueva cuenta", style: TextStyle(fontSize: 18, color: Colors.black87)),
            ),
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
    final formProvider = Provider.of<LoginFormProvider>(context);
    return Form(
        key: formProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: formProvider.emailController,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "john.doe@gmail.com",
                  labelText: "Correo electrónico",
                  prefixIcon: Icons.alternate_email_sharp),
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? "") ? null : "El valor ingresado no luce como un correo";
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: formProvider.passwordController,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              decoration: InputDecorations.authInputDecoration(
                  hintText: "*****", labelText: "Contraseña", prefixIcon: Icons.lock_outline),
              validator: (value) {
                if (value != null && value.length >= 6) return null;
                return "La contraseña debe ser de 6 caracteres";
              },
            ),
            const SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: AppColor.primaryColor,
              onPressed: formProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!formProvider.isValidForm()) return;
                      formProvider.isLoading = true;
                      final authService = Provider.of<AuthService>(context, listen: false);
                      final String? errorMessage = await authService.login(formProvider.email, formProvider.password);
                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, HomePage.routeName);
                      } else {
                        NotificationsService.showSnackbar(errorMessage);
                      }
                      formProvider.isLoading = false;
                    },
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: formProvider.isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : const Text("Ingresar", style: TextStyle(color: Colors.white))),
            )
          ],
        ));
  }
}
