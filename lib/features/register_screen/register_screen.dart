import 'dart:developer';

import 'package:driver_app/features/register_screen/blocs/register_bloc.dart';
import 'package:driver_app/ultis/ultis_export.dart';
import 'package:driver_app/widgets/widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const routeName = 'resgiterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showPass = false;

  final TextEditingController _repeatPasswordController =
      TextEditingController();
  bool showRepeatPass = false;

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            color: Colors.white,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height),
            child: Form(
              key: _keyForm,
              child: BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  if(state is RegisterSuccess) {
                    showSnackbar('Đăng ký thành công, đăng nhập để tiếp tục', context, true);
                  }else if(state is RegisterFailed) {
                    showSnackbar('Đăng ký thất bại', context, false);
                  }
                },
                child: BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.cover,
                                height: 200,
                                width: 200,
                              ),
                            ]),
                        const SizedBox(height: 12.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Đăng Ký',
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
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: 'Nhập tên',
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green.shade900),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0))),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)))),
                        ),
                        const SizedBox(height: 12.0),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0))),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0))),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)))),
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          controller: _repeatPasswordController,
                          obscureText: !showRepeatPass,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    showRepeatPass = !showRepeatPass;
                                  });
                                },
                                child: Icon(showRepeatPass == false
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              suffixIconColor: Colors.grey,
                              hintText: 'Nhập lại mật khẩu',
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green.shade900),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12.0))),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0)))),
                        ),
                        const SizedBox(height: 24.0),
                        ButtonCustom(
                            width: MediaQuery.of(context).size.width * 3 / 4,
                            height: 40.0,
                            color: (state is RegisterPeding)
                                ? Colors.grey.shade600
                                : Colors.green.shade900,
                            text: (state is RegisterPeding)
                                ? 'Loading...'
                                : 'Đăng ký',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: (state is RegisterPeding)
                                        ? Colors.black
                                        : Colors.white),
                            radius: 30.0,
                            onTap: (state is RegisterPeding)
                                ? () {}
                                : () {
                                    log('NAME: ${_nameController.text}');
                                    log('PHONE NUMBER: ${_phoneNumberController.text}');
                                    log('PASSWORD: ${_passwordController.text}');
                                    log('REPEATPASSWORD: ${_repeatPasswordController.text}');
                                    context.read<RegisterBloc>().add(Register(
                                        name: _nameController.text,
                                        phoneNumber:
                                            _phoneNumberController.text,
                                        password: _passwordController.text,
                                        repeatPassword:
                                            _repeatPasswordController.text));
                                  })
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
