import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/tasks/models/task_response.dart';
import 'package:task_pulse/features/tasks/repositories/task_repository.dart';

part 'task_cubit_state.dart';
part 'task_cubit_cubit.freezed.dart';

@injectable
class TaskCubit extends Cubit<TaskState> {
  final TaskRepository _dashboardRepository;

  TaskCubit(this._dashboardRepository) : super(const _Initial());
  Future<void> getTaskById(String taskId) async {
    try {
      emit(const _Loading());
      final task = await _dashboardRepository.getTaskById(taskId);
      emit(_Success(task!));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
