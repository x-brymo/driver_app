// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

part of 'participation_bloc.dart';

abstract class ParticipationEvent extends Equatable {
  const ParticipationEvent();

  @override
  List<Object> get props => [];
}

class GetMessageList extends ParticipationEvent {
  final String orderId;
  
  const GetMessageList({
    required this.orderId,
  });

  @override
  List<Object> get props => [
    orderId
  ];
}

class SendMessage extends ParticipationEvent {
  final String guard;
  final String message;
  final String orderId;
  final String serverKey;

  const SendMessage({
    required this.guard,
    required this.message,
    required this.orderId,
    required this.serverKey,
  });

  @override
  List<Object> get props => [
    guard,
    message,
    orderId,
    serverKey
  ];
}
