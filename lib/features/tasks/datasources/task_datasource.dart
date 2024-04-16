// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/tasks/models/task_response.dart';

@lazySingleton
class TaskRemoteDatasourceImpl {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String _collectionPath = 'tasks';
  final String _orderedField = 'id';
  String weatherApiUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey = "881d71da6b2f9965eb67f52c52bbe361";

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

  Future<void> addTask(TaskResponse task) async {
    final collectionRef = firestore.collection(_collectionPath);

    final querySnapshot = await collectionRef.get();

    final newId = querySnapshot.docs.length + 2;

    final Map<String, dynamic> taskData = task.toJson();
    taskData['id'] = newId.toString();

    await collectionRef.doc('$newId').set(taskData);
  }

  Future<void> removeTask(TaskResponse task) async {
    try {
      final collection = FirebaseFirestore.instance.collection('tasks');
      collection
          .doc('${task.id}')
          .delete()
          .then((_) => print('Deleted'))
          .catchError((error) => print('Delete failed: $error'));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> closeTask(TaskResponse task) async {
    await firestore.collection(_collectionPath).doc('${task.id}').update({'taskStatus': 1});
  }

  Future<List<TaskResponse>> getUserAssignedTasks(String userId) async {
    List<TaskResponse> userTasks = [];

    final result = await firestore.collection(_collectionPath).where('assignedTo', isEqualTo: userId).get();
    for (var snapshot in result.docs) {
      TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
      userTasks.add(newTask);
    }
    return userTasks;
  }

  Future<void> editTask(TaskResponse editedTask) async {
    try {
      final collection = FirebaseFirestore.instance.collection('tasks');
      collection
          .doc('${editedTask.id}')
          .update(editedTask.toJson())
          .then((_) => print('Updated'))
          .catchError((error) => print('Update failed: $error'));
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TaskResponse>> getHighPriorityTasks() async {
    List<TaskResponse> highPriorityTasks = [];

    final result = await firestore.collection(_collectionPath).where('taskPriority', isEqualTo: 2).get();
    for (var snapshot in result.docs) {
      TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
      highPriorityTasks.add(newTask);
    }
    return highPriorityTasks;
  }

  Future<List<TaskResponse>> getLowPriorityTasks() async {
    List<TaskResponse> lowPriorityTasks = [];

    final result = await firestore.collection(_collectionPath).where('taskPriority', isEqualTo: 1).get();
    for (var snapshot in result.docs) {
      TaskResponse newTask = TaskResponse.fromJson(snapshot.data());
      lowPriorityTasks.add(newTask);
    }
    return lowPriorityTasks;
  }

  Future<TaskResponse?> getTaskById(String taskId) async {
    try {
      final DocumentSnapshot taskSnapshot = await firestore.collection(_collectionPath).doc(taskId).get();
      if (taskSnapshot.exists) {
        TaskResponse task = TaskResponse.fromJson(taskSnapshot.data() as Map<String, dynamic>);
        return task;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to get task by ID: $e');
    }
  }
}
