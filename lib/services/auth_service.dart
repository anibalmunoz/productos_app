import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:productos_app/utils/app_config.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = "identitytoolkit.googleapis.com";
  final String firebaseToken = "AIzaSyAyvv8E3dpNrO5A-P0sgMzRoTIGf8Qgk_I";
  final storage = const FlutterSecureStorage();

  Future<String?> firebaseAuth(String email, String password, String endopoint) async {
    final Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };
    final url = Uri.https(_baseUrl, endopoint, {"key": firebaseToken});
    final response = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodedRes = jsonDecode(response.body);
    if (decodedRes.containsKey("idToken")) {
      await storage.write(key: AppConfig.idToken, value: decodedRes["idToken"]);
      return null;
    } else {
      return decodedRes["error"]["message"];
    }
  }

  Future<String?> createUser(String email, String password) async {
    return firebaseAuth(email, password, "/v1/accounts:signUp");
  }

  Future<String?> login(String email, String password) async {
    return firebaseAuth(email, password, "/v1/accounts:signInWithPassword");
  }

  Future<void> logout() async {
    await storage.delete(key: AppConfig.idToken);
  }

  Future<String> isAuthenticated() async {
    return await storage.read(key: AppConfig.idToken) ?? "";
  }
}
