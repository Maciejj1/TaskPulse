import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_pulse/features/auth/data/repositories/auth_repository.dart';
import 'package:task_pulse/utils/services/shared/user_manager.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const _Init());

  Future<void> singInFormSubmitted(String email, String password, void Function() go) async {
    try {
      await _authRepository.singIn(email: email, password: password);

      emit(const _Success());
      go();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const _Failure('User not found'));
      } else if (e.code == 'wrong-password') {
        emit(const _Failure('Wrong password'));
      }
    } on PlatformException catch (e) {
      if (e.message == 'ERROR_WRONG_PASSWORD') {
        emit(const _Failure('Wrong password'));
      } else if (e.code == 'ERROR_USER_NOT_FOUND') {
        emit(const _Failure('User not found'));
      }
    } catch (e) {
      emit(_Failure(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _authRepository.sendPasswordResetEmail(email);
      emit(const _Success());
    } catch (_) {
      emit(const _Failure('Failed to send password reset email'));
    }
  }

  Future<void> logOut(void Function() go) async {
    try {
      await _authRepository.logOut();
      UserManager().clearUID();
      emit(const _Success());
      go();
    } catch (_) {
      emit(const _Failure('Failed to log out'));
    }
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await _authRepository.changePassword(newPassword);
      emit(const _Success());
    } catch (_) {
      emit(const _Failure('Failed to change password'));
    }
  }

  Future<void> changeEmail(String newEmail) async {
    try {
      await _authRepository.changeEmail(newEmail);
      emit(const _Success());
    } catch (_) {
      emit(const _Failure('Failed to change email'));
    }
  }
}
