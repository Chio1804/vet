part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginEmailChanged extends LoginEvent {
  final String email;
  LoginEmailChanged(this.email);
}

final class LoginPasswordChanged extends LoginEvent {
  final String password;
  LoginPasswordChanged(this.password);
}

final class LoginSubmitted extends LoginEvent {}
