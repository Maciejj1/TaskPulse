import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:task_pulse/features/auth/data/models/user_model.dart';
import 'package:task_pulse/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:task_pulse/utils/services/shared/user_manager.dart';

class AuthRemoteDatasource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthRemoteDatasource({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  var currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> signUp({required String email, required String password, required String name}) async {
    try {
      final firebase_auth.UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      UserManager().setUID(uid);
      User user = User(date: DateTime.now(), name: name, password: password, email: email, gender: 0, id: "1");
      await DashboardRemoteDatasourceImpl().updateUserData(user, uid);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> singIn({required String email, required String password}) async {
    try {
      final firebase_auth.UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      UserManager().setUID(uid);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }

  Future<void> changePassword(String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> changeEmail(String newEmail) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      rethrow;
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName);
  }
}
