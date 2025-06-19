part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

final class RegisterEmailChanged extends RegisterEvent {
  final String email;
  RegisterEmailChanged(this.email);
}

final class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  RegisterPasswordChanged(this.password);
}

final class RegisterSubmitted extends RegisterEvent {}
