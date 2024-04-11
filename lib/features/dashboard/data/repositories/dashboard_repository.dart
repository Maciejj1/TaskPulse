import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/auth/data/models/user_model.dart';
import 'package:task_pulse/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';

@lazySingleton
class DashboardRepository {
  final DashboardRemoteDatasourceImpl dashboardRemoteDatasource;

  DashboardRepository(this.dashboardRemoteDatasource);

  Future<WeatherResponse> getWeather(String cityName) async {
    try {
      return await dashboardRemoteDatasource.getWeather(cityName);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> getCurrentCity() async {
    try {
      final city = await dashboardRemoteDatasource.getCurrentCity();
      return city;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> getProfile() async {
    try {
      return await dashboardRemoteDatasource.getUserData();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<User>> getUsers() async {
    try {
      return await dashboardRemoteDatasource.getAllUsers();
    } catch (e) {
      throw Exception(e);
    }
  }
}
