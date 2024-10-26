import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/driver.dart';
import 'package:equatable/equatable.dart';

part 'driver_notification_event.dart';
part 'driver_notification_state.dart';

class DriverNotificationBloc extends Bloc<DriverNotificationEvent, DriverNotificationState> {
  DriverNotificationBloc() : super(DriverNotificationInitial()) {
    on<GetDriverNotifications>(_onGetDriverNotifications);
  }

  void _onGetDriverNotifications(GetDriverNotifications event, Emitter<DriverNotificationState> emit) async {
    emit(GetDriverNotificationsPeding());

    ApiResponse response = await DriverService.getDriverNotifications(
      event.guard,
      event.id
    );
    if(response.success == true) {
      emit(GetDriverNotificationsSuccess(apiResponse: response));
    }else {
      emit(GetDriverNotificationsFailed(message: response.message));
    }
  }
}
