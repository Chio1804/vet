import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseAuth _firebaseAuth;

  RegisterBloc({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth,
        super(const RegisterState()) {
    on<RegisterEmailChanged>(
        (event, emit) => emit(state.copyWith(email: event.email)));

    on<RegisterPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    on<RegisterSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      RegisterSubmitted event, Emitter<RegisterState> emit) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: RegisterStatus.submitting));
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: e.message,
      ));
    } catch (_) {
      emit(state.copyWith(
        status: RegisterStatus.failure,
        errorMessage: 'An unknown error occurred',
      ));
    }
  }
}
