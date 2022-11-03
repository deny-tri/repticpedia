import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repticpedia/src/model/models.dart';
import 'package:repticpedia/src/service/services.dart';
import 'package:repticpedia/src/utilitie/utilities.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<LoadUserData>((event, emit) async {
      emit(UserIsLoading());
      String? uid = await Commons().getUID();
      final result = await UserServices().loadUserData(uid);
      emit(
        result.fold(
          (l) => UserIsFailed(message: l),
          (r) {
            Commons().setUID(r.uid!);
            return UserIsSuccess(data: r);
          },
        ),
      );
    });
    on<LogOutUser>((event, emit) async {
      emit(UserIsLogOut());
      await Commons().removeUID();
      UserServices().logOutUser();
    });
  }
}
