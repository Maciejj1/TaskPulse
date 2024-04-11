import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/auth/data/models/user_model.dart';
import 'package:task_pulse/features/dashboard/data/repositories/dashboard_repository.dart';

part 'edit_task_state.dart';
part 'edit_task_cubit.freezed.dart';

@injectable
class EditTaskCubit extends Cubit<EditTaskState> {
  final DashboardRepository _dashboardRepository;

  EditTaskCubit(this._dashboardRepository) : super(const _Initial());

  Future<void> getAllUsers() async {
    try {
      emit(const _Loading());
      final users = await _dashboardRepository.getUsers();
      emit(_Success(users));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
