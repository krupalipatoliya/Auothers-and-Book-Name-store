import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseCloudHelpper {
  FireBaseCloudHelpper._();

  static final FireBaseCloudHelpper fireBaseCloudHelpper =
      FireBaseCloudHelpper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      {required String book, required String auother}) async {
    CollectionReference users = firestore.collection('Registration');
    print("add");
    users.doc().set({'book': book, 'author': auother});

    print("add 2");
  }

  Stream<QuerySnapshot> fetchAllData() {
    firestore.collection('Registration').snapshots();

    Stream<QuerySnapshot> collectionStream =
        firestore.collection('Registration').snapshots();

    return collectionStream;
  }

  Future<void> deleteUser({required String i}) {
    CollectionReference users = firestore.collection('Registration');
    return users
        .doc(i)
        .delete()
        .then((value) => print("User Deleted"))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  Future<void> updateUser(
      {required String i, required String book, required String auother}) {
    CollectionReference users = firestore.collection('Registration');

    return users
        .doc(i)
        .update({'book': book, 'author': auother})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
