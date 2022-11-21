import 'dart:convert';
import 'package:flutter/foundation.dart';

APIResponse apiResponseFromBytes(Uint8List str, int statusCode) =>
    apiResponseFromJson(const Utf8Decoder().convert(str), statusCode);

APIResponse apiResponseFromJson(String str, int statusCode) {
  dynamic body;
  try {
    body = json.decode(str);
  } catch (e) {
    body = {"error": e.toString(), "success": false};
    statusCode = 400;
  }
  return APIResponse.fromJson(
    body,
    statusCode,
  );
}

String apiResponseToJson(APIResponse data) => json.encode(data.toJson());

class APIResponse {
  APIResponse(
      {required this.statusCode,
      required this.data,
      this.error,
      this.currentPage,
      this.pages,
      this.count,
      this.next,
      this.previous,
      this.results});

  final int statusCode;
  final String? data;
  final String? error;

  // Paginated responses
  final int? currentPage, pages, count;
  final String? next, previous;
  final List? results;

  factory APIResponse.fromJson(Map<String, dynamic> json, int statusCode) =>
      APIResponse(
        statusCode: statusCode,
        data: json['data'],
        error: (json['error'] ?? [null])[0],
        currentPage: json['current_page'],
        pages: json['pages'],
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: json['results'],
      );

  Map<String, dynamic> toJson() => {
        'statusCode': statusCode,
        if (data != null) 'data': data,
        if (error != null) 'error': error,
        if (currentPage != null) 'current_page': currentPage,
        if (pages != null) 'pages': pages,
        if (count != null) 'count': count,
        if (next != null) 'next': next,
        if (previous != null) 'previous': previous,
        if (results != null) 'results': results,
      };
}
