import 'dart:convert';
import 'dart:developer';

import 'package:driver_app/constants/constants_export.dart';
import 'package:driver_app/constants/errors.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static Future<ApiResponse> getOrdersList(
      String date, String id, String guard, String token) async {
    final uri = Uri.parse('$GET_ORDERS_LIST?date=$date&id=$id&guard=$guard');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> updateOrder(
      int id, Map<String, dynamic> data, String token) async {
    final uri = Uri.parse('$ORDER_UPDATE/$id');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response =
        await http.put(uri, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> getIncomeStatistic(
      String type, String id, String token) async {
    final uri = Uri.parse('$GET_INCOME_STATISTIC$type&id=$id');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> updateDriverLocation(Map<String, dynamic> data, String token) async {
    final uri = Uri.parse(UPDATE_DRIVER_LOCATION);

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.post(uri, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log('DATA: $data');
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }
}
