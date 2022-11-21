import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:bienestar_mobile/backend/models/response.dart';
import 'package:bienestar_mobile/backend/models/user.dart';

class AuthService with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  User? _user;
  String host = 'ec59-2800-484-188b-7712-d06a-d4ce-7726-db45.ngrok.io';

  User? get user {
    return _user ?? loadUser();
  }

  Future<String> getToken() async {
    final token = await _storage.read(key: 'token');
    return token!;
  }

  Future<APIResponse> login(String email, String password) async {
    var uri = Uri.https(host, 'accounts/auth/login/');
    final resp = await http.post(
      uri,
      body: {"email": email, "password": password},
    );
    APIResponse response = apiResponseFromBytes(
      resp.bodyBytes,
      resp.statusCode,
    );
    if (response.statusCode == 200) {
      await _saveUser(resp.body);
      // response.data = user.toString();
    } else {
      // response.data = "Error";
    }
    return response;
  }

  loadUser() {
    final userStr = _storage.read(key: 'user');
    userStr.then((value) {
      if (value != null) {
        _user = User.fromJson(jsonDecode(value));
        notifyListeners();
      }
    });
  }

  Future _saveUser(String userStr) async {
    _user = userFromJson(userStr);
    notifyListeners();
    return await _storage.write(key: 'user', value: userStr);
  }

  Future logout() async {
    await _storage.delete(key: 'user');
    _user = null;
    notifyListeners();
  }
}
