import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  final String _baseUrl = "https://identitytoolkit.googleapis.com";
  final String firebaseToken = "AIzaSyAyvv8E3dpNrO5A-P0sgMzRoTIGf8Qgk_I";

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {"email ": email, "password": password};
    final url = Uri.https(_baseUrl, "/v1/accounts:signUp", {"key": firebaseToken});
    final response = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodedData = jsonDecode(response.body);
  }
}
