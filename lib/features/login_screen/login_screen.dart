import 'dart:io';
import 'dart:developer';

import 'package:driver_app/configs/configs_export.dart';
import 'package:driver_app/features/login_screen/login_components/login_components_export.dart';
import 'package:driver_app/ultis/ultis_export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final NotificationSetup _noti = NotificationSetup();
  final ConnectToPusher connectToPusher = ConnectToPusher();

  @override
  void initState() {
    super.initState();
    
    getServerKey();
    getTokenDevice();
    connectToPusher.connecToPusher();
    _noti.configurePushNotifications(context);
    _noti.eventListenerCallback(context);
  }

  void getTokenDevice() async {
    if(Platform.isAndroid) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = await FirebaseMessaging.instance.getToken();
      log('TOKEN DEVICE: $token');
      prefs.setString('tokenDevice', token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            color: Colors.white,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height),
            child: const PhoneNumberForm(),
          ),
        ),
      ),
    );
  }
}
