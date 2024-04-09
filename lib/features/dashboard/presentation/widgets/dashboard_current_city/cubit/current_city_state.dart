part of 'current_city_cubit.dart';

@freezed
class CurrentCityState with _$CurrentCityState {
  const factory CurrentCityState.initial() = _Initial;
  const factory CurrentCityState.loading() = _Loading;
  const factory CurrentCityState.success(String city) = _Success;
  const factory CurrentCityState.error(String message) = _Error;
}
