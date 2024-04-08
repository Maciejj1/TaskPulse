import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';
import 'package:task_pulse/features/dashboard/data/repositories/dashboard_repository.dart';

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
      await _dashboardRepository.addTask(task);
      final tasks = await _dashboardRepository.getAllTasks();
      emit(_Success(tasks));
    } catch (e) {
      emit(_Error(e.toString()));
    }
  }

  Future<void> removeTask(TaskResponse task) async {
    try {
      emit(const _Loading());
      await _dashboardRepository.removeTask(task);
      final tasks = await _dashboardRepository.getAllTasks();
      emit(_Success(tasks));
    } catch (e) {
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

  Future<String> getCurrentCity() async {
    try {
      return await _dashboardRepository.getCurrentCity();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<WeatherResponse> getWeather(String cityName) async {
    try {
      return await _dashboardRepository.getWeather(cityName);
    } catch (e) {
      throw Exception(e);
    }
  }
}
