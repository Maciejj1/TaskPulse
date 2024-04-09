import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_pulse/features/auth/data/models/user_model.dart';
import 'package:task_pulse/features/dashboard/data/repositories/dashboard_repository.dart';

part 'profile_state.dart';
part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final DashboardRepository _dashboardRepository;

  ProfileCubit(this._dashboardRepository) : super(const _Initial());

  Future<void> getProfile() async {
    try {
      emit(const _Loading());
      final profile = await _dashboardRepository.getProfile();
      emit(_Success(profile));
    } catch (e) {
      emit(_Error(e.toString()));
      print(e);
    }
  }
}
