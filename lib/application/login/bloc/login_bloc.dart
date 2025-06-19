import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;

  LoginBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(const LoginState()) {
    on<LoginEmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.email)),
    );
    on<LoginPasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.password)),
    );
    on<LoginSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Email dan password harus diisi.',
      ));
      return;
    }

    emit(state.copyWith(status: LoginStatus.submitting, errorMessage: null));

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: LoginStatus.success));
    } on FirebaseAuthException catch (e) {
      String message = 'Terjadi kesalahan saat login.';
      if (e.code == 'user-not-found') {
        message = 'Email tidak ditemukan.';
      } else if (e.code == 'wrong-password') {
        message = 'Password salah.';
      } else if (e.code == 'invalid-email') {
        message = 'Format email tidak valid.';
      }

      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: message,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'Terjadi kesalahan tidak diketahui.',
      ));
    }
  }
}
