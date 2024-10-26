import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'drawer_event.dart';
part 'drawer_state.dart';

class DrawerBloc extends Bloc<DrawerEvent, DrawerState> {
  DrawerBloc() : super(DrawerInitial()) {
    on<Logout>(_onLogout);
  }

  void _onLogout(Logout event, Emitter<DrawerState> emit) async {
    emit(LogoutPending());

    AuthResponse authResponse = await AuthService.Logout(event.token);
    if(authResponse.success == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      emit(LogoutSuccess(authResponse: authResponse));
    }else {
      emit(LogoutError(message: authResponse.message));
    }
  }
}
