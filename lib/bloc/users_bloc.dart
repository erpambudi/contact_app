import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contact_app/data/models/models.dart';
import 'package:contact_app/data/services/services.dart';
import 'package:equatable/equatable.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersServices usersServices;
  UsersBloc(this.usersServices) : super(UsersInitial());

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if (event is GetUserData) {
      yield UsersInitial();
      ServicesReturnValue result = await UsersServices.getUser(event.id);
      if (result.value != null) {
        yield UsersLoadSuccess(result.value);
      } else {
        yield UsersError();
      }
    }
  }
}
