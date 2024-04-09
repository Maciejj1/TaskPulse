import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';
import 'package:task_pulse/features/dashboard/data/repositories/dashboard_repository.dart';

part 'weather_state.dart';
part 'weather_cubit.freezed.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final DashboardRepository _dashboardRepository;

  WeatherCubit(this._dashboardRepository) : super(const _Initial());

  Future<void> getWeather() async {
    try {
      emit(const _Loading());
      final city = await _dashboardRepository.getCurrentCity();
      final weather = await _dashboardRepository.getWeather(city);
      print(weather);
      emit(_Success(weather));
    } catch (e) {
      throw Exception(e);
    }
  }
}
