import 'package:freezed_annotation/freezed_annotation.dart';
part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    final String? cityName,
    final double? temperature,
    final String? mainCondition,
  }) = _WeatherResponse;

  const WeatherResponse._();

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
}
