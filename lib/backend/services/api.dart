import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:bienestar_mobile/backend/models/response.dart';
import 'package:bienestar_mobile/backend/models/user.dart';

class API with ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  User? _user;
  static const String host =
      '71ec-2800-484-188b-7712-9c6-e8b-a6dc-3e4f.ngrok.io';

  User? get user {
    return _user ?? _loadUser();
  }

  Future<APIResponse> get(String path,
      {bool authenticate = false, Map<String, String>? query}) async {
    final uri = Uri.https(host, path, query);
    final resp = await http.get(
      uri,
      headers: authenticate ? {'Authorization': 'Token ${_user?.token}'} : null,
    );
    APIResponse response = apiResponseFromBytes(
      resp.bodyBytes,
      resp.statusCode,
    );
    return response;
  }

  Future<APIResponse> post(String path,
      {bool authenticate = false, Object? body}) async {
    final uri = Uri.https(host, path);
    final resp = await http.post(uri,
        headers: authenticate
            ? {
                'Authorization': 'Token ${_user?.token}',
                'Content-type': 'application/json',
                'Accept': 'application/json',
              }
            : null,
        body: jsonEncode(body));
    APIResponse response = apiResponseFromBytes(
      resp.bodyBytes,
      resp.statusCode,
    );
    return response;
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

  Future logout() async {
    await _storage.delete(key: 'user');
    _user = null;
    notifyListeners();
  }

  _loadUser() {
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

  Future getHours() async {
    APIResponse response = await get('/promoter/record/', authenticate: true);
    print(response.raw);
    return response.results;
  }
}
