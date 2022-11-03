import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repticpedia/src/model/models.dart';
import 'package:repticpedia/src/service/services.dart';
import 'package:repticpedia/src/utilitie/utilities.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(RegisterIsLoading());
      final result = await UserServices().registerWithEmail(
          email: event.email, name: event.username, password: event.password);
      emit(
        result.fold(
          (l) => RegisterIsFailed(message: l),
          (r) {
            Commons().setUID(r.uid!);
            return RegisterIsSuccess(data: r);
          },
        ),
      );
    });
  }
}
