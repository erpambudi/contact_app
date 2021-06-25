part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoadSuccess extends UsersState {
  final UserData users;

  UsersLoadSuccess(this.users);
}

class UsersError extends UsersState {}
