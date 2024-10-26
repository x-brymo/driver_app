import 'dart:convert';
import 'dart:developer';

import 'package:driver_app/constants/apis.dart';
import 'package:driver_app/constants/errors.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:http/http.dart' as http;

class DriverService {
  static Future<ApiResponse> update(int id, Map<String, dynamic> data, String token) async {
    final uri = Uri.parse('$DRIVER_UPDATE/$id');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(data)
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if(response.statusCode == 500) {
      return const ApiResponse(
        success: false, 
        data: null, 
        message: INVALID
      );
    }
    return const ApiResponse(
      success: false, 
      data: null, 
      message: SOME_THING_WENT_WRONG
    );
  }

  // Don't need token
  static Future<ApiResponse> getDriverNotifications(String guard, String id) async {
    final uri = Uri.parse('$GET_DRIVER_NOTIFICATIONS$guard&id=$id');

    final headers = {
      "Accept": "application/json"
    };

    final response = await http.get(
      uri,
      headers: headers
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if(response.statusCode == 500) {
      return const ApiResponse(
        success: false, 
        data: null, 
        message: INVALID
      );
    }
    return const ApiResponse(
      success: false, 
      data: null, 
      message: SOME_THING_WENT_WRONG
    );
  }

  static Future<ApiResponse> updateProfile(String token, Map<String, dynamic> data, String userId) async {
    final uri = Uri.parse('$UPDATE_PROFILE/$userId');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.put(uri, headers: headers, body: jsonEncode(data));
    log('SERVICE: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse.fromMap(data);
      return apiResponse;
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }
}