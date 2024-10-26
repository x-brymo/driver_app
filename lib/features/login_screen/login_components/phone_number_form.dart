// ignore_for_file: use_build_context_synchronously

import 'package:driver_app/configs/pusher.dart';
import 'package:driver_app/features/login_screen/bloc/auth_bloc.dart';
import 'package:driver_app/features/login_screen/login_components/icon_login.dart';
import 'package:driver_app/features/otp_verify_screen/otp_verify_screen.dart';
import 'package:driver_app/ultis/ultis_export.dart';
import 'package:driver_app/widgets/widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberForm extends StatefulWidget {
  const PhoneNumberForm({
    super.key,
  });

  @override
  State<PhoneNumberForm> createState() => _PhoneNumberFormState();
}

class _PhoneNumberFormState extends State<PhoneNumberForm> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ConnectToPusher connectToPusher = ConnectToPusher();

  bool showPass = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is Success) {
          Navigator.pushNamed(context, OtpVerifyScreen.routeName);
        } else if (state is Error) {
          showSnackbar(state.message, context, false);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Form(
            key: _keyForm,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const IconLogin(),
                const SizedBox(height: 12.0),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    'Đăng Nhập',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.bold),
                  )
                ]),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Nhập số điện thoại',
                      enabledBorder: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green.shade900),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0)))),
                ),
                const SizedBox(height: 12.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !showPass,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        child: Icon(showPass == false
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      suffixIconColor: Colors.grey,
                      hintText: 'Nhập mật khẩu',
                      enabledBorder: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green.shade900),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12.0))),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius:
                              BorderRadius.all(Radius.circular(12.0)))),
                ),
                const SizedBox(height: 24.0),
                ButtonCustom(
                  width: MediaQuery.of(context).size.width * 3 / 4,
                  height: 40.0,
                  color: (state is Peding)
                      ? Colors.grey.shade600
                      : Colors.green.shade900,
                  text: (state is Peding) ? 'Loading...' : 'Tiếp tục',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: (state is Peding) ? Colors.black : Colors.white),
                  radius: 30.0,
                  onTap: (state is Peding)
                      ? () {}
                      : () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          final tokenDevice = prefs.getString('tokenDevice');
                          final serverKey = prefs.getString('serverKey');
                          context.read<AuthBloc>().add(Login(
                              phoneNumber: _phoneNumberController.text,
                              password: _passwordController.text,
                              token: tokenDevice!,
                              serverKey: serverKey!,
                              guard: 'driver'));
                        },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
  }
}
