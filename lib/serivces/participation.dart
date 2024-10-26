import 'dart:convert';

import 'package:driver_app/constants/constants_export.dart';
import 'package:driver_app/constants/errors.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:http/http.dart' as http;

class ParticipationService {
  static Future<ApiResponse> getMessages(String orderId) async {
    final uri = Uri.parse('$GET_MESSAGES_URL?orderId=$orderId');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> sendMessage(
      String token, Map<String, dynamic> data) async {
    final uri = Uri.parse(DRIVER_SEND_MESSAGE_URL);

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response =
        await http.post(uri, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }
}
