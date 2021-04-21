import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user.dart';

class RegisterLoginRequest {
  Future<ModelUser> getLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User currentUser = FirebaseAuth.instance.currentUser;
      //await currentUser.reload();
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .get();
      if (documentSnapshot.exists && documentSnapshot
          .data()
          .isNotEmpty) {
        ModelUser modelUser = ModelUser.fromMap(documentSnapshot.data());
        return modelUser;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return null;
  }

  Future<ModelUser> saveUser(ModelUser modelUser) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: modelUser.email, password: modelUser.password);
      User currentUser = FirebaseAuth.instance.currentUser;
      //await currentUser.reload();
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .set(modelUser.toMap());
      return modelUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        throw ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        throw ('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      throw (e);
    }

    return null;
  }
}
