// ignore_for_file: use_build_context_synchronously

import 'package:driver_app/configs/pusher.dart';
import 'package:driver_app/features/otp_verify_screen/components/components_export.dart';
import 'package:flutter/material.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  static const routeName = 'OtpVerifyScreen';

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  ConnectToPusher pusher = ConnectToPusher();

  @override
  void initState() {
    pusher.connecToPusher();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios
          ),
        ),
        title: Text(
          'Xác thực số điện thoại',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.white,
            fontSize: 22.0
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - AppBar().preferredSize.height
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: const OtpForm(),
      ),
    );
  }
}