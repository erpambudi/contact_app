part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends UsersEvent {
  final String id;

  GetUserData(this.id);
}
