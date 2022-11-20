import 'package:bienestar_mobile/backend/models/response.dart';
import 'package:http/http.dart' as http;

class API {
  static const String host =
      'https://ec59-2800-484-188b-7712-d06a-d4ce-7726-db45.ngrok.io';

  static Future<APIResponse> get(String path) async {
    final uri = Uri.https(host, path);
    final resp = await http.get(
      uri,
    );
    APIResponse response = apiResponseFromBytes(
      resp.bodyBytes,
      resp.statusCode,
    );
    return response;
  }
}
