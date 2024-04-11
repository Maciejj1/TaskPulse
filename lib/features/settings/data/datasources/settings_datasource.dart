// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SettingsRemoteDatasourceImpl {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> changeUserName(String newName, String uid) async {
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = userCollection.doc(uid);
    await userDoc.update({'name': newName});
  }

  Future<void> changeUserPassword(String newPassword, String uid) async {
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = userCollection.doc(uid);
    await userDoc.update({'password': newPassword});
  }

  Future<void> changeUserEmail(String newEmail, String uid) async {
    final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
    DocumentReference userDoc = userCollection.doc(uid);
    await userDoc.update({'email': newEmail});
  }
}
