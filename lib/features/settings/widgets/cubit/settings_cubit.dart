import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/settings/data/repositories/settings_repository.dart';
import 'package:task_pulse/utils/services/shared/user_manager.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository _dashboardRepository;

  SettingsCubit(this._dashboardRepository) : super(const _Initial());

  Future<void> changePassword(
    String password,
  ) async {
    try {
      UserManager userManager = UserManager();
      String? userId = await userManager.getUID();
      emit(const _Loading());
      await _dashboardRepository.changePassword(password, userId!);
      emit(const _Success());
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> changeName(
    String name,
  ) async {
    try {
      UserManager userManager = UserManager();
      String? userId = await userManager.getUID();
      emit(const _Loading());
      await _dashboardRepository.changeName(name, userId!);
      emit(const _Success());
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> changeEmail(
    String email,
  ) async {
    try {
      UserManager userManager = UserManager();
      String? userId = await userManager.getUID();
      emit(const _Loading());
      await _dashboardRepository.changeEmail(email, userId!);
      emit(const _Success());
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
