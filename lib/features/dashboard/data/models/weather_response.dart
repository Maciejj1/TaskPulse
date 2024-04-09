import 'package:freezed_annotation/freezed_annotation.dart';
part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    final String? name,
    final Main? main,
    final List<Weather>? weather,
  }) = _WeatherResponse;

  const WeatherResponse._();

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
}

@freezed
class Main with _$Main {
  const factory Main({
    final double? temp,
    final double? feels_like,
    final double? temp_min,
    final double? temp_max,
    final int? pressure,
    final int? humidity,
  }) = _Main;

  const Main._();

  factory Main.fromJson(Map<String, dynamic> json) => _$MainFromJson(json);
}

@freezed
class Weather with _$Weather {
  const factory Weather({
    final int? id,
    final String? main,
    final String? description,
    final String? icon,
  }) = _Weather;

  const Weather._();

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
}
