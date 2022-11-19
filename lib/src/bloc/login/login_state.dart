// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginIsLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginIsFailed extends LoginState {
  final String message;
  LoginIsFailed({
    required this.message,
  });
}

class Authenticated extends LoginState {
  @override
  List<Object?> get props => [];
}

class UnAuthenticated extends LoginState {
  @override
  List<Object?> get props => [];
}

class AuthError extends LoginState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}

class LoginIsSuccess extends LoginState {}
