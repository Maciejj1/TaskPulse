import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';
import 'package:task_pulse/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:task_pulse/utils/services/shared/user_manager.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepository _dashboardRepository;

  DashboardCubit(this._dashboardRepository) : super(const _Initial());

  Future<void> getAllTasks() async {
    try {
      emit(const _Loading());
      final tasks = await _dashboardRepository.getAllTasks();
      emit(_Success(tasks));
    } catch (e) {
      emit(_Error(e.toString()));
      print(e);
    }
  }

  Future<void> getClosedTasks() async {
    try {
      emit(const _Loading());
      final tasks = await _dashboardRepository.getClosedTasks();
      emit(_Success(tasks));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> addTask(TaskResponse task) async {
    try {
      emit(const _Loading());
      UserManager userManager = UserManager();
      String? userName = await userManager.getName();
      await _dashboardRepository.addTask(TaskResponse(
          taskName: task.taskName,
          taskDeadline: task.taskDeadline,
          taskDesciption: task.taskDesciption,
          taskPriority: task.taskPriority,
          taskStatus: task.taskStatus,
          owner: userName));
      final tasks = await _dashboardRepository.getAllTasks();
      emit(_Success(tasks));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> removeTask(TaskResponse task) async {
    try {
      emit(const _Loading());
      print("Cubit: $task");

      await _dashboardRepository.removeTask(task);
      final tasks = await _dashboardRepository.getAllTasks();
      emit(_Success(tasks));
    } catch (e) {
      print(e.toString());
      emit(_Error(e.toString()));
    }
  }

  Future<void> closeTask(TaskResponse task) async {
    try {
      emit(const _Loading());
      await _dashboardRepository.closeTask(task);
      final tasks = await _dashboardRepository.getAllTasks();
      emit(_Success(tasks));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> editTask(TaskResponse editedTask) async {
    try {
      emit(const _Loading());
      await _dashboardRepository.editTask(TaskResponse(
        id: editedTask.id,
        taskName: editedTask.taskName,
        taskDeadline: editedTask.taskDeadline,
        taskDesciption: editedTask.taskDesciption,
        taskPriority: editedTask.taskPriority,
        taskStatus: editedTask.taskStatus,
        owner: editedTask.owner,
      ));
      final tasks = await _dashboardRepository.getAllTasks();
      emit(_Success(tasks));
    } catch (e) {
      print(e.toString());

      emit(_Error(e.toString()));
    }
  }

  Future<void> getUserAssignedTasks() async {
    try {
      emit(const _Loading());
      String? userId = await UserManager().getUID();
      final tasks = await _dashboardRepository.getUserAssignedTasks(userId!);
      emit(_Success(tasks));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> getHighPriorityTasks() async {
    try {
      emit(const _Loading());
      final tasks = await _dashboardRepository.getHighPriorityTasks();
      emit(_Success(tasks));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> getLowPriorityTasks() async {
    try {
      emit(const _Loading());
      final tasks = await _dashboardRepository.getLowPriorityTasks();
      emit(_Success(tasks));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }
}
