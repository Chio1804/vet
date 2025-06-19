part of 'register_bloc.dart';

enum RegisterStatus { initial, submitting, success, failure }

class RegisterState extends Equatable {
  final String email;
  final String password;
  final RegisterStatus status;
  final String? errorMessage;

  const RegisterState({
    this.email = '',
    this.password = '',
    this.status = RegisterStatus.initial,
    this.errorMessage,
  });

  bool get isValid => email.isNotEmpty && password.length >= 6;

  RegisterState copyWith({
    String? email,
    String? password,
    RegisterStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage];
}
