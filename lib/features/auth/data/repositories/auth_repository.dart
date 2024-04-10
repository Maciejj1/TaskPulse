import 'package:task_pulse/features/auth/data/datasources/auth_remote_datasource.dart';

class AuthRepository {
  AuthRemoteDatasource remoteDatasource = AuthRemoteDatasource();
  Future<void> signUp({required String email, required String password, required String name}) async {
    try {
      await remoteDatasource.signUp(email: email, password: password, name: name);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> singIn({required String email, required String password}) async {
    try {
      await remoteDatasource.singIn(email: email, password: password);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await remoteDatasource.logOut();
    } catch (_) {}
  }

  Future<void> changePassword(String newPassword) async {
    try {
      await remoteDatasource.changePassword(newPassword);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await remoteDatasource.sendPasswordResetEmail(email);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changeEmail(String newEmail) async {
    try {
      await remoteDatasource.changeEmail(newEmail);
    } catch (error) {
      rethrow;
    }
  }
}
