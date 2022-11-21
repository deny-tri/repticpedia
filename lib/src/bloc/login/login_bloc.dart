import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repticpedia/src/service/services.dart';
import 'package:repticpedia/src/utilitie/utilities.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUser>(
      (event, emit) async {
        emit(LoginIsLoading());
        final result = await UserServices()
            .loginWithEmail(email: event.email, password: event.password);
        emit(
          result.fold(
            (l) => LoginIsFailed(message: l),
            (r) {
              Commons().setUID(r.uid!);
              return LoginIsSuccess();
            },
          ),
        );
      },
    );
    on<GoogleSignInRequested>((event, emit) async {
      emit(LoginIsLoading());
      try {
        await UserServices().signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(LoginIsLoading());
      await UserServices().logOutUser();
      emit(UnAuthenticated());
    });
  }
}
