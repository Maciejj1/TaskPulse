import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';

abstract class DashboardRemoteDatasource {
  Future<List<TaskResponse>> getAllTasks();
  Future<List<TaskResponse>> getClosedTasks();
  Future<void> addTask(TaskResponse task);
  Future<void> removeTask(TaskResponse task);
  Future<void> closeTask(TaskResponse task);
  Future<WeatherResponse> getWeather(String cityName);
  Future<String> getCurrentCity();
}

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'tasks';
  final String _orderedField = 'id';
  String WEATHER_API_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "";

  @override
  Future<List<TaskResponse>> getAllTasks() async {
    List<TaskResponse> tasks = [];

    final result = await firestore.collection(_collectionPath).orderBy(_orderedField).get();
    for (var snapshot in result.docs) {
      TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
      tasks.add(newTask);
    }
    return tasks;
  }

  @override
  Future<List<TaskResponse>> getClosedTasks() async {
    List<TaskResponse> closedTasks = [];
    TaskResponse? task;
    final result = await firestore.collection(_collectionPath).where(task!.taskStatus == 1).get();
    for (var snapshot in result.docs) {
      TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
      closedTasks.add(newTask);
    }
    return closedTasks;
  }

  @override
  Future<void> addTask(TaskResponse task) async {
    await firestore.collection(_collectionPath).add(task.toJson());
  }

  @override
  Future<void> removeTask(TaskResponse task) async {
    await firestore.collection(_collectionPath).doc(task.id).delete();
  }

  @override
  Future<void> closeTask(TaskResponse task) async {
    await firestore.collection(_collectionPath).doc(task.id).update({'taskStatus': 1});
  }

  @override
  Future<WeatherResponse> getWeather(String cityName) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey';
    final dio = Dio(); // Creating an instance of Dio
    final response = await dio.get(url); // Calling the get method on the instance
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.data));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        return 'Brak uprawnien';
      }
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    String? city = placemarks[0].locality;
    return city ?? "";
  }
}
