import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_pulse/features/auth/data/repositories/auth_repository.dart';

part 'register_state.dart';
part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterCubit(this._authRepository) : super(const _Initial());

  Future<void> signUpFormSubmitted(String name, String email, String password, void Function() go) async {
    emit(const _Loading());
    try {
      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
      emit(const _Success());
      go();
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
