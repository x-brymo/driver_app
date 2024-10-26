
import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState()) {
    on<DriverActive>(_onDriverActive);
    on<UpdateDriverLocation>(_onUpdateDriverLocation);
  }

  void _onDriverActive(DriverActive event, Emitter<HomeState> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id')!;
    String token = prefs.getString('token')!;
    Map<String, dynamic> data = {
      'current_location': event.currentLocation,
      'status': event.status
    };

    ApiResponse response = await DriverService.update(id, data, token);
  
    if(response.success == true) {
      emit(ActiveSuccess());
    } else {
      emit(ActiveFailed());
    }
  }

  void _onUpdateDriverLocation(UpdateDriverLocation event, Emitter emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;

    Map<String, dynamic> data = {
      'lat': event.lat,
      'lng': event.lng,
      'receiverId': event.receiverId
    };

    ApiResponse response = await OrderService.updateDriverLocation(data, token);
  
    if(response.success == true) {
      emit(UpdatedDriverLocationSuccess(apiResponse: response));
    } else {
      emit(UpdatedDriverLocationFailed(message: response.message));
    }
  }
}
