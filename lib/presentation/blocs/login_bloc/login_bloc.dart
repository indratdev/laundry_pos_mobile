import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/datasource/auth_remote_datasource.dart';
import '../../../data/models/response/auth_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource authRemoteDatasource;

  LoginBloc(this.authRemoteDatasource) : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      try {
        final response = await authRemoteDatasource.login(
          event.email,
          event.password,
        );
        response.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      } on TimeoutException catch (err) {
        emit(LoginState.error(err.toString()));
      } catch (e) {
        emit(LoginState.error(e.toString()));
      }
    });
  }
}
