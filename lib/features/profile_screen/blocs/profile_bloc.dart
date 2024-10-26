import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfile>(_onUpdateProfile);
  }

  void _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(UpdateProfilePeding());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    int id = prefs.getInt('id')!;

    Map<String, dynamic> data = event.avatar == ''
        ? {
            'name': event.name,
            'phone_number': event.phoneNumber,
          }
        : {
            'name': event.name,
            'phone_number': event.phoneNumber,
            'avatar': event.avatar
          };

    ApiResponse apiResponse =
        await DriverService.updateProfile(token, data, id.toString());

    if (apiResponse.success == true) {
      UserModel user =
          UserModel.fromMap(apiResponse.data as Map<String, dynamic>);
      log('USER: $user');
      prefs.setString('userName', user.name);
      prefs.setString('phoneNumber', user.phoneNumber);
      prefs.setString('avatar', user.avatar!);
      emit(UpdateProfileSuccess(apiResponse: apiResponse));
    } else {
      emit(UpdateProfileFailed(message: apiResponse.message));
    }
  }
}
