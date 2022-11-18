import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:bienestar_mobile/backend/models/user.dart';


class AuthService with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  late User user;
  String host = 'https://33c0-2800-484-188b-7712-496a-9254-487f-b581.ngrok.io';

  Future<String> getToken() async {
    final token = await _storage.read(key: 'token');
    return token!;
  }

  Future login(String email, String password) async {
    var uri = Uri.https(host, 'accounts/auth/login/');
    final resp = await http.post(
      uri,
      body: {"email": email, "password": password},
    );

    if (resp.statusCode == 200) {
      user = userFromJson(resp.body);
      // await this._saveToken(loginResponse.token);
      return {"success": true};
    } else {
      print(resp);
      return {"success": false, "data": resp.body};
    }
  }

  Future isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    return token;
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
