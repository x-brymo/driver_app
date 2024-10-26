// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'participation_bloc.dart';

abstract class ParticipationState extends Equatable {
  const ParticipationState();
  
  @override
  List<Object> get props => [];
}

class ParticipationInitial extends ParticipationState {}

class GetMessageListPeding extends ParticipationState {}

class GetMessageListFailed extends ParticipationState {
  final String message;

  const GetMessageListFailed({
    required this.message,
  });

  @override
  List<Object> get props => [ message ];
}

class GetMessageListSuccess extends ParticipationState {
  final List<ChatModel> chats;
  
  const GetMessageListSuccess({
    required this.chats,
  });

  @override
  List<Object> get props => [
    chats
  ];
}

class SendMessagePeding extends ParticipationState {}

class SendMessageFailed extends ParticipationState {
  final String message;

  const SendMessageFailed({
    required this.message,
  });

  @override
  List<Object> get props => [ message ];
}

class SendMessageSuccess extends ParticipationState {
  final ApiResponse message;
  
  const SendMessageSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [
    message
  ];
}
