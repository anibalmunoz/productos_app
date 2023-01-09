import 'package:flutter/material.dart';
import 'package:productos_app/pages/pages.dart';
import 'package:productos_app/routes/app_routes.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/themes/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductService()),
        ChangeNotifierProvider(create: (context) => AuthService())
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',
      scaffoldMessengerKey: NotificationsService.messengerKey,
      initialRoute: CheckAuthPage.routeName,
      routes: getAppRoutes,
      theme: getAppTheme(),
    );
  }
}
