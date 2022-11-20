import 'dart:convert';
import 'package:flutter/foundation.dart';

APIResponse apiResponseFromBytes(Uint8List str, int statusCode) =>
    APIResponse.fromJson(
      json.decode(const Utf8Decoder().convert(str)),
      statusCode,
    );

APIResponse apiResponseFromJson(String str, int statusCode) {
  dynamic body;
  try {
    body = json.decode(str);
  } catch (e) {
    body = '{"error": "$e", "success": false}';
    statusCode = 400;
  }
  return APIResponse.fromJson(
    body,
    statusCode,
  );
}

String apiResponseToJson(APIResponse data) => json.encode(data.toJson());

class APIResponse {
  APIResponse({
    required this.statusCode,
    required this.success,
    required this.data,
    this.error,
  });

  final int statusCode;
  final bool success;
  String? data;
  final String? error;

  factory APIResponse.fromJson(Map<String, dynamic> json, int statusCode) =>
      APIResponse(
        statusCode: statusCode,
        success: json['success'] ?? statusCode == 200,
        data: json['data'],
        error: (json['error'] ?? [null])[0],
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        'success': success,
        if (data != null) 'data': data,
        if (error != null) 'error': error,
      };
}
