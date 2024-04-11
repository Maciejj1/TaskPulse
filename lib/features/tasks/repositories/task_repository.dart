import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/tasks/datasources/task_datasource.dart';
import 'package:task_pulse/features/tasks/models/task_response.dart';

@lazySingleton
class TaskRepository {
  final TaskRemoteDatasourceImpl taskRemoteDatasource;

  TaskRepository(this.taskRemoteDatasource);

  Future<List<TaskResponse>> getAllTasks() async {
    try {
      return await taskRemoteDatasource.getAllTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TaskResponse>> getClosedTasks() async {
    try {
      return await taskRemoteDatasource.getClosedTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> addTask(TaskResponse task) async {
    try {
      return await taskRemoteDatasource.addTask(task);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> removeTask(TaskResponse task) async {
    try {
      return await taskRemoteDatasource.removeTask(task);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> closeTask(TaskResponse task) async {
    try {
      return await taskRemoteDatasource.closeTask(task);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TaskResponse>> getUserAssignedTasks(String userId) async {
    try {
      return await taskRemoteDatasource.getUserAssignedTasks(userId);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> editTask(TaskResponse editedTask) async {
    try {
      return await taskRemoteDatasource.editTask(editedTask);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TaskResponse>> getHighPriorityTasks() async {
    try {
      return await taskRemoteDatasource.getHighPriorityTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<TaskResponse>> getLowPriorityTasks() async {
    try {
      return await taskRemoteDatasource.getLowPriorityTasks();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<TaskResponse?> getTaskById(String taskId) async {
    try {
      return await taskRemoteDatasource.getTaskById(taskId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
