import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/dashboard/data/repositories/dashboard_repository.dart';

part 'current_city_state.dart';
part 'current_city_cubit.freezed.dart';

@injectable
class CurrentCityCubit extends Cubit<CurrentCityState> {
  final DashboardRepository _dashboardRepository;

  CurrentCityCubit(this._dashboardRepository) : super(const _Initial());

  Future<String> getCurrentCity() async {
    try {
      emit(const _Loading());
      final city = await _dashboardRepository.getCurrentCity();
      emit(_Success(city));
      return city; // Add this return statement
    } catch (e) {
      throw Exception(e);
    }
  }
}
