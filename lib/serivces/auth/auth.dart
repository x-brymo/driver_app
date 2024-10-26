// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:driver_app/constants/errors.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:http/http.dart' as http;
import 'package:driver_app/constants/constants_export.dart';

class AuthService {
  static Future<AuthResponse> Login(String phoneNumber, String password, String token, String guard, String serverKey) async {
    final uri = Uri.parse(LOGIN_URL);

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    final body = {
      "phone_number": phoneNumber,
      "password": password,
      "token": token,
      "serverKey": serverKey,
      "guard": guard
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body)
    );
    if(response.statusCode == 200) {
      final data = json.decode(response.body);
      AuthResponse authResponse = AuthResponse.fromMap(data); 
      return authResponse;
    } else if(response.statusCode == 500) {
      return const AuthResponse(
        success: false, 
        data: null, 
        message: INVALID
      );
    }
    return const AuthResponse(
      success: false, 
      data: null, 
      message: SOME_THING_WENT_WRONG
    );
  }

  static Future<ApiResponse> Register(String name, String phoneNumber, String password, String repeatPassword) async {
    final uri = Uri.parse(REGISTER_URL);

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    final body = {
      "name": name,
      "phone_number": phoneNumber,
      "password": password,
      "password_confirmation" : repeatPassword
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body)
    );

    if(response.statusCode == 200) {
      final data = json.decode(response.body);
      ApiResponse ok = ApiResponse.fromMap(data); 
      return ok;
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

  static Future<AuthResponse> Logout(String token) async {
    final uri = Uri.parse(LOGOUT_DRIVER_URL);

    final headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.post(
      uri,
      headers: headers
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return AuthResponse.fromMap(data);
    } else if(response.statusCode == 500) {
      return const AuthResponse(
        success: false, 
        data: null, 
        message: INVALID
      );
    } else if(response.statusCode == 401) {
      return const AuthResponse(
        success: false, 
        data: null, 
        message: UNAUTHORIZED
      );
    }
    return const AuthResponse(
      success: false, 
      data: null, 
      message: SOME_THING_WENT_WRONG
    );
  }
}