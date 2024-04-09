import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:task_pulse/features/auth/data/models/user_model.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';
import 'package:task_pulse/utils/services/shared/user_manager.dart';

abstract class DashboardRemoteDatasource {
  Future<List<TaskResponse>> getAllTasks();
  Future<List<TaskResponse>> getClosedTasks();
  Future<void> addTask(TaskResponse task);
  Future<void> removeTask(TaskResponse task);
  Future<void> closeTask(TaskResponse task);
  Future<WeatherResponse> getWeather(String cityName);
  Future<String> getCurrentCity();
  Future<void> updateUserData(User userModel, String uid);
  Future<User> getUserData();
}

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'tasks';
  final String _orderedField = 'id';
  String WEATHER_API_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "881d71da6b2f9965eb67f52c52bbe361";

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
    try {
      final url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';
      final response = await Dio().get(url,
          options: Options(validateStatus: (_) => true, headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }));
      if (response.statusCode == 200) {
        final responseData = response.data;
        print("Response: $responseData");
        return WeatherResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
    }
  }

  @override
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
    if (placemarks.isEmpty) {
      return 'Nie można znaleźć danych dotyczących lokalizacji';
    }

    String? city = placemarks[0].locality;

    return city ?? "asasas";
  }

  @override
  Future<User> getUserData() async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();
    final DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    User? userProfile;
    if (profileSnapshot.exists) {
      DateTime? date = profileSnapshot.get('date')?.toDate();

      userProfile = User.fromJson({
        'id': profileSnapshot.get('id'),
        'date': date.toString(),
        'name': profileSnapshot.get('name'),
        'password': profileSnapshot.get('password'),
        'email': profileSnapshot.get('email'),
        'gender': profileSnapshot.get('gender'),
      });
    }
    return userProfile!;
  }

  @override
  Future<void> updateUserData(User userModel, String uid) async {
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic> userData = {
      'id': userModel.id,
      'date': userModel.date,
      'name': userModel.name,
      'password': userModel.password,
      'email': userModel.email,
      'gender': userModel.gender
    };
    DocumentReference userDoc = userCollection.doc(uid);
    await userDoc.set(userData);
    CollectionReference userProfileCol = FirebaseFirestore.instance.collection('profile');
    await userProfileCol.add(userData);
  }
}
