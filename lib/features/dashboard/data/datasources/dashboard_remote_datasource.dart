// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/auth/data/models/user_model.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';
import 'package:task_pulse/utils/services/shared/user_manager.dart';

@lazySingleton
class DashboardRemoteDatasourceImpl {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "881d71da6b2f9965eb67f52c52bbe361";

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
        return WeatherResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      throw Exception('Failed to load weather: $e');
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
    if (placemarks.isEmpty) {
      return 'Nie można znaleźć danych dotyczących lokalizacji';
    }

    String? city = placemarks[0].locality;

    return city ?? "asasas";
  }

  Future<User> getUserData() async {
    UserManager userManager = UserManager();
    String? userID = await userManager.getUID();
    final DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance.collection('users').doc(userID).get();
    User? userProfile;
    if (profileSnapshot.exists) {
      Timestamp? timestamp = profileSnapshot.get('date');
      userProfile = User.fromJson({
        'id': profileSnapshot.get('id'),
        'date': timestamp,
        'name': profileSnapshot.get('name'),
        'password': profileSnapshot.get('password'),
        'email': profileSnapshot.get('email'),
        'gender': profileSnapshot.get('gender'),
      });
      String userName = userProfile.name!;
      userManager.setName(userName);
    }
    return userProfile!;
  }

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

  Future<List<User>> getAllUsers() async {
    List<User> users = [];

    try {
      final result = await FirebaseFirestore.instance.collection('users').get();
      for (var snapshot in result.docs) {
        User newUser = User.fromJson(snapshot.data());
        users.add(newUser);
      }
      return users;
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }
}
