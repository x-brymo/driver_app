import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<Register>(_onRegister);
  }

  void _onRegister(Register event, Emitter<RegisterState> emit) async {
    emit(RegisterPeding());

    ApiResponse apiResponse = await AuthService.Register(
        event.name, event.phoneNumber, event.password, event.repeatPassword);
    log(apiResponse.data.toString());
    if(apiResponse.success == true) {
      emit(RegisterSuccess(authResponse: apiResponse));
    }else {
      emit(RegisterFailed(message: apiResponse.message));
    }
  }
}
