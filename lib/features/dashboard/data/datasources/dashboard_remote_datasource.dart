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
  Future<List<TaskResponse>> getUserAssignedTasks(String userId);
  Future<void> editTask(TaskResponse editedTask);
  Future<List<TaskResponse>> getHighPriorityTasks();
  Future<List<TaskResponse>> getLowPriorityTasks();
  Future<List<User>> getAllUsers();
  Future<void> changeUserName(String newName, String uid);
  Future<void> changeUserEmail(String newEmail, String uid);
  Future<void> changeUserPassword(String newPassword, String uid);
}

class DashboardRemoteDatasourceImpl implements DashboardRemoteDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'tasks';
  final String _orderedField = 'id';
  String weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "881d71da6b2f9965eb67f52c52bbe361";

  @override
  Future<List<TaskResponse>> getAllTasks() async {
    List<TaskResponse> tasks = [];

    try {
      final result = await firestore.collection(_collectionPath).orderBy(_orderedField).get();
      for (var snapshot in result.docs) {
        TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
        tasks.add(newTask);
      }
      return tasks;
    } catch (e) {
      throw Exception(e);
    }
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
    // Pobierz referencję do kolekcji
    final collectionRef = firestore.collection(_collectionPath);

    // Pobierz wszystkie dokumenty w kolekcji
    final querySnapshot = await collectionRef.get();

    // Oblicz nowy ID
    final newId = querySnapshot.docs.length + 1;

    // Utwórz mapę zawierającą zadanie i ustaw jej ID
    final Map<String, dynamic> taskData = task.toJson();
    taskData['id'] = newId.toString();

    // Zamiast używać add(), użyj doc() z nazwą dokumentu i set() aby ustawić dane
    await collectionRef.doc('$newId').set(taskData);
  }

  Future<void> removeTask(TaskResponse task) async {
    try {
      print("Próba usunięcia zadania: $task");
      final collection = FirebaseFirestore.instance.collection('tasks');
      collection
          .doc('${task.id}') // <-- Doc ID to be deleted.
          .delete() // <-- Delete
          .then((_) => print('Deleted'))
          .catchError((error) => print('Delete failed: $error'));

      print("Zadanie zostało pomyślnie usunięte.");
    } catch (e) {
      print("Wystąpił błąd podczas usuwania zadania: $e");
      throw Exception(e);
    }
  }

  @override
  Future<void> closeTask(TaskResponse task) async {
    await firestore.collection(_collectionPath).doc('${task.id}').update({'taskStatus': 1});
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

  @override
  Future<List<TaskResponse>> getUserAssignedTasks(String userId) async {
    List<TaskResponse> userTasks = [];

    final result = await firestore.collection(_collectionPath).where('assignedTo', isEqualTo: userId).get();
    for (var snapshot in result.docs) {
      TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
      userTasks.add(newTask);
    }
    return userTasks;
  }

  @override
  Future<void> editTask(TaskResponse editedTask) async {
    try {
      print("EDITED TASK DATA: ${editedTask.toJson()}");
      final collection = FirebaseFirestore.instance.collection('tasks');
      collection
          .doc('${editedTask.id}') // <-- Doc ID to be deleted.
          .update(editedTask.toJson()) // <-- Delete
          .then((_) => print('Updated'))
          .catchError((error) => print('Update failed: $error'));
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<TaskResponse>> getHighPriorityTasks() async {
    List<TaskResponse> highPriorityTasks = [];

    final result = await firestore.collection(_collectionPath).where('taskPriority', isEqualTo: 2).get();
    for (var snapshot in result.docs) {
      TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
      highPriorityTasks.add(newTask);
    }
    return highPriorityTasks;
  }

  @override
  Future<List<TaskResponse>> getLowPriorityTasks() async {
    List<TaskResponse> lowPriorityTasks = [];

    final result = await firestore.collection(_collectionPath).where('taskPriority', isEqualTo: 1).get();
    for (var snapshot in result.docs) {
      TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
      lowPriorityTasks.add(newTask);
    }
    return lowPriorityTasks;
  }

  @override
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

  @override
  Future<void> changeUserName(String newName, String uid) async {
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = userCollection.doc(uid);
    await userDoc.update({'name': newName});
  }

  @override
  Future<void> changeUserPassword(String newPassword, String uid) async {
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = userCollection.doc(uid);
    await userDoc.update({'password': newPassword});
  }

  @override
  Future<void> changeUserEmail(String newEmail, String uid) async {
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = userCollection.doc(uid);
    await userDoc.update({'email': newEmail});
  }
}
