part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccess extends AuthState {
  final UserData userResult;

  AuthSuccess(this.userResult);

  @override
  List<Object> get props => [userResult];
}

class AuthFailed extends AuthState {
  final String messages;

  AuthFailed(this.messages);

  @override
  List<Object> get props => [messages];
}
