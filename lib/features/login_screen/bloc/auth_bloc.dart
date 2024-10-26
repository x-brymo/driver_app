
import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<Login>(_onLogin);
  }

  void _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(Peding());
    AuthResponse authReponse = await AuthService.Login(
        event.phoneNumber, event.password, event.token, event.guard, event.serverKey);
    if (authReponse.success == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      DriverModel driver = authReponse.data!.driver;
      prefs.setInt('id', driver.id);
      prefs.setString('userName', driver.name);
      prefs.setString('phoneNumber', driver.phoneNumber);
      prefs.setString('avatar', driver.avatar!);
      prefs.setDouble('reviewRate', driver.reviewRate!);
      prefs.setInt('status', driver.status);
      prefs.setString('token', authReponse.data!.token);
      emit(Success(response: authReponse));
    } else {
      emit(Error(message: authReponse.message));
    }
  }
}
