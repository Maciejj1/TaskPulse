import 'package:injectable/injectable.dart';
import 'package:task_pulse/features/settings/data/datasources/settings_datasource.dart';

@lazySingleton
class SettingsRepository {
  final SettingsRemoteDatasourceImpl settingsRemoteDatasource;

  SettingsRepository(this.settingsRemoteDatasource);

  Future<void> changeEmail(String email, String uid) async {
    try {
      return await settingsRemoteDatasource.changeUserEmail(email, uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> changePassword(String password, String uid) async {
    try {
      return await settingsRemoteDatasource.changeUserPassword(password, uid);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> changeName(String password, String uid) async {
    try {
      return await settingsRemoteDatasource.changeUserName(password, uid);
    } catch (e) {
      throw Exception(e);
    }
  }
}
