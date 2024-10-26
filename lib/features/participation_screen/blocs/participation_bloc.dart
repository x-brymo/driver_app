import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:driver_app/models/models_export.dart';
import 'package:driver_app/serivces/services_export.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'participation_event.dart';
part 'participation_state.dart';

class ParticipationBloc extends Bloc<ParticipationEvent, ParticipationState> {
  ParticipationBloc() : super(ParticipationInitial()) {
    on<GetMessageList>(_onGetMessageList);
    on<SendMessage>(_onSendMessage);
  }

  void _onGetMessageList(
      GetMessageList event, Emitter<ParticipationState> emit) async {
    emit(GetMessageListPeding());

    ApiResponse apiResponse =
        await ParticipationService.getMessages(event.orderId);

    if (apiResponse.success == true) {
      List<ChatModel> chats = (apiResponse.data as List<dynamic>)
          .map((e) => ChatModel.fromMap(e))
          .toList();
      log('CHATS: $chats');
      emit(GetMessageListSuccess(chats: chats));
    } else {
      emit(GetMessageListFailed(message: apiResponse.message));
    }
  }

  void _onSendMessage(SendMessage event, Emitter<ParticipationState> emit) async {
    emit(SendMessagePeding());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token')!;
    
    Map<String, dynamic> data = {
      "guard": event.guard,
      "message": event.message,
      "order_id": event.orderId,
      "server_key": event.serverKey
    };
    
    ApiResponse apiResponse =
        await ParticipationService.sendMessage(token, data);

    if (apiResponse.success == true) {
      log(apiResponse.data.toString());
      emit(SendMessageSuccess(message: apiResponse));
    } else {
      emit(SendMessageFailed(message: apiResponse.message));
    }
  }
}
