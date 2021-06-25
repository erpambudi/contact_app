part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequest extends AuthEvent {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterRequest extends AuthEvent {
  final String name;
  final String email;
  final String password;

  RegisterRequest(
      {required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}
