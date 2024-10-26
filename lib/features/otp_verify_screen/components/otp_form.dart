// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:driver_app/features/export_features.dart';
import 'package:driver_app/ultis/ultis_export.dart';
import 'package:driver_app/widgets/widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
  });

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final TextEditingController _otpController = TextEditingController();

  final GlobalKey<FormState> _otpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _otpKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nhập mã OTP',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900)),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Vui lòng nhập mã OTP vừa gửi tới máy bạn',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey)),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 18),
          PinCodeTextField(
            controller: _otpController,
            appContext: context,
            length: 4,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              fieldWidth: 60,
              fieldHeight: 70,
              shape: PinCodeFieldShape.box,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              activeColor: Colors.grey,
              inactiveColor: Colors.grey,
              selectedColor: Colors.green.shade700,
              errorBorderColor: Colors.red,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Otp không được trống';
              }
              return null;
            },
          ),
          const SizedBox(height: 42.0),
          ButtonCustom(
            width: MediaQuery.of(context).size.width * 3 / 4,
            height: 40.0,
            color: Colors.green.shade700,
            text: 'Xác thực',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.white),
            radius: 30.0,
            onTap: () async {
              if (_otpKey.currentState!.validate()) {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                final otpCode = prefs.getString('otpCode');
                log('OTP CODE: $otpCode');
                if (otpCode == _otpController.text) {
                  prefs.remove('otpCode');
                  prefs.remove('tokenDevice');
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeScreen.routeName, (route) {
                    return route.settings.name == SplashScreen.screenName;
                  });
                } else {
                  showSnackbar('Mã OTP không chính xác', context, false);
                }
              }
            },
          )
        ],
      ),
    );
  }
}
