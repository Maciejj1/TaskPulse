import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:task_pulse/features/auth/data/models/user_model.dart';
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
      print('Expenses data has been updated for the user with UID: $uid');
    } catch (error) {
      print('Błąd podczas logowania lub rejestracji: $error');
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
      print('Błąd w funkcji: $error');
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }

  // Future<String> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
  //   final firebase_auth.AuthCredential credential = firebase_auth.GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //   final firebase_auth.UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
  //   final firebase_auth.User user = authResult.user!;
  //   assert(!user.isAnonymous);
  //   final firebase_auth.User currentUser = _firebaseAuth.currentUser!;
  //   assert(user.uid == currentUser.uid);
  //   // Check if this is the first login for the user
  //   final DocumentSnapshot userDataSnapshot =
  //       await FirebaseFirestore.instance.collection('mainCollection').doc(user.uid).get();

  //   if (!userDataSnapshot.exists) {
  //     List<UserProfile> profile = [
  //       UserProfile(pictureImage: '', name: user.displayName!, password: '', email: user.email!, dateOfBirth: '', id: 1)
  //     ];
  //     String uid = user.uid;
  //     UserManager().setUID(uid);
  //     await _createInitialUserData(uid);
  //     await ProfileRepository(uid: uid).updateUserData(profile);
  //   }
  //   return 'signInWithGoogle succeeded: $user';
  // }

  Future<void> changePassword(String newPassword) async {
    try {
      final user = _firebaseAuth.currentUser;

      if (user != null) {
        await user.updatePassword(newPassword);
        // Password updated successfully
      } else {
        // No user is currently signed in
        // Handle this case (e.g., prompt the user to sign in)
      }
    } catch (error) {
      print('Error changing password: $error');
      // Handle the error (e.g., display an error message to the user)
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
    } catch (error) {
      print('Error sending password reset email: $error');
      // Handle the error (e.g., display an error message to the user)
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName);
  }
}
