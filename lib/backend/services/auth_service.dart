import 'dart:convert';

import 'package:bienestar_mobile/backend/models/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:bienestar_mobile/backend/models/user.dart';

class AuthService with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  User? _user;
  String host = '87b6-3-231-165-123.ngrok.io';

  User? get user {
    return _user ?? loadUser();
  }

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
    APIResponse response = apiResponseFromBytes(
      resp.bodyBytes,
      resp.statusCode,
    );
    if (response.success) {
      await _saveUser(resp.body);
      response.data = user.toString();
    } else {
      response.data = "Error";
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
