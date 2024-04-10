import 'package:task_pulse/features/auth/data/models/user_model.dart';
import 'package:task_pulse/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';

class DashboardRepository {
  final DashboardRemoteDatasource dashboardRemoteDatasource;

  DashboardRepository(this.dashboardRemoteDatasource);

  Future<List<TaskResponse>> getAllTasks() async {
    try {
      return await dashboardRemoteDatasource.getAllTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TaskResponse>> getClosedTasks() async {
    try {
      return await dashboardRemoteDatasource.getClosedTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addTask(TaskResponse task) async {
    try {
      return await dashboardRemoteDatasource.addTask(task);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeTask(TaskResponse task) async {
    try {
      print("Repozytorium: $task");

      return await dashboardRemoteDatasource.removeTask(task);
    } catch (e) {
      print(e);

      throw Exception(e);
    }
  }

  Future<void> closeTask(TaskResponse task) async {
    try {
      return await dashboardRemoteDatasource.closeTask(task);
    } catch (e) {
      throw Exception(e);
    }
  }

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

  Future<List<TaskResponse>> getUserAssignedTasks(String userId) async {
    try {
      return await dashboardRemoteDatasource.getUserAssignedTasks(userId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> editTask(TaskResponse editedTask) async {
    try {
      print("Repozytorium edycji: $editedTask");

      return await dashboardRemoteDatasource.editTask(editedTask);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TaskResponse>> getHighPriorityTasks() async {
    try {
      return await dashboardRemoteDatasource.getHighPriorityTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TaskResponse>> getLowPriorityTasks() async {
    try {
      return await dashboardRemoteDatasource.getLowPriorityTasks();
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

  Future<void> changeEmail(String email, String uid) async {
    try {
      return await dashboardRemoteDatasource.changeUserEmail(email, uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> changePassword(String password, String uid) async {
    try {
      return await dashboardRemoteDatasource.changeUserPassword(password, uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> changeName(String password, String uid) async {
    try {
      return await dashboardRemoteDatasource.changeUserName(password, uid);
    } catch (e) {
      throw Exception(e);
    }
  }
}
