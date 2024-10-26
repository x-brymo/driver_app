import 'dart:convert';
import 'dart:io';

import 'package:driver_app/configs/configs_export.dart';
import 'package:driver_app/features/profile_screen/blocs/profile_bloc.dart';
import 'package:driver_app/ultis/ultis_export.dart';
import 'package:driver_app/widgets/widgets_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const routeName = 'profileScreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  File? _imageFile;
  final _picker = ImagePicker();
  String? imgBase64;

  bool _isEditing = false;
  @override
  void initState() {
    super.initState();
    prepare();
  }

  void prepare() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('userName')!;
    _phoneController.text = prefs.getString('phoneNumber')!;

    if (prefs.getString('avatar') != '') {
      File ans =
          await downloadAndSaveImage(prefs.getString('avatar').toString());
      setState(() {
        _imageFile = ans;
      });
    }
  }

  static String? getStringImage(File? file) {
    if (file == null) return null;
    return base64Encode(file.readAsBytesSync());
  }

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imgBase64 = getStringImage(_imageFile);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Trang cá nhân',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          TextButton(
              onPressed: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              child: Text(
                _isEditing == false ? 'Chỉnh sửa' : 'Huỷ',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: _isEditing == false ? Colors.green : Colors.red),
              ))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height),
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is UpdateProfilePeding) {
                  showDialog(
                      context: context,
                      builder: (context) => Center(
                            child: CircularProgressIndicator(
                              color: Colors.green.shade800,
                            ),
                          ));
                } else if (state is UpdateProfileSuccess) {
                  navigatorKey.currentState!.pop();
                }
              },
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onLongPress: _isEditing == true
                                ? () {
                                    getImage();
                                  }
                                : null,
                            child: _imageFile != null
                                ? Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        image: _imageFile != null
                                            ? DecorationImage(
                                                image: FileImage(
                                                    _imageFile ?? File('')),
                                                fit: BoxFit.cover)
                                            : null,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(100))),
                                  )
                                : SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: Image.asset(
                                      'assets/images/img_empty.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text('Họ và tên'),
                              subtitle: TextFormField(
                                enabled: _isEditing,
                                validator: (name) {
                                  if (name!.isEmpty) {
                                    return 'Tên không được để trống';
                                  }
                                  return null;
                                },
                                controller: _nameController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green)),
                                    hintText: 'Nguyễn Văn A...',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.grey)),
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            ListTile(
                              title: const Text('Số điện thoại'),
                              subtitle: TextFormField(
                                enabled: _isEditing,
                                validator: (phone) {
                                  if (phone!.isEmpty) {
                                    return 'Số điện thoại không được để trống';
                                  }
                                  if (phone.length < 10) {
                                    return 'Số điện thoại không đủ kí tự';
                                  }
                                  return null;
                                },
                                controller: _phoneController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.green)),
                                    hintText: '0373...',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.grey)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 42.0),
                      _isEditing == true
                          ? ButtonCustom(
                              width: MediaQuery.of(context).size.width * 3 / 4,
                              height: 40.0,
                              color: Colors.green.shade900,
                              text: 'Cập nhật',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.white),
                              radius: 30.0,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                  context.read<ProfileBloc>().add(UpdateProfile(
                                      name: _nameController.text,
                                      phoneNumber: _phoneController.text,
                                      avatar: imgBase64 ?? ''));
                                }
                              })
                          : const SizedBox.shrink()
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
