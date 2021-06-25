import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contact_app/data/models/models.dart';
import 'package:contact_app/data/services/services.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthServices authServices;
  AuthBloc(this.authServices) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is RegisterRequest) {
      yield AuthInitial();
      SignInSignUpResult? result = await authServices.signUp(
          name: event.name, email: event.email, password: event.password);

      if (result!.user != null) {
        yield AuthSuccess(result.user!);
      } else if (result.message != null) {
        yield AuthFailed(result.message!);
      }
    } else if (event is LoginRequest) {
      yield AuthInitial();
      SignInSignUpResult? result =
          await authServices.signIn(event.email, event.password);
      if (result!.user != null) {
        yield AuthSuccess(result.user!);
      } else if (result.message != null) {
        yield AuthFailed(result.message!);
      }
    }
  }
}
