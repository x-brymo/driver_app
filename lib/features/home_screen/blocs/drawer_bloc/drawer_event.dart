part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  const DrawerEvent();

  @override
  List<Object> get props => [];
}

class Logout extends DrawerEvent {
  final String token;

  const Logout({
    required this.token
  });

  @override
  List<Object> get props => [ token ];
}
