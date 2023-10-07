import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitplus/src/controller/splash_screens_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FbFireStoreController {
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> read(
      {required String nameCollection,
      required String orderBy,
      required bool descending}) async* {
    yield* _firebaseFirestore
        .collection(nameCollection)
        .orderBy(orderBy, descending: descending)
        .snapshots();
  }

  Future<bool> createUser(
      {required BuildContext context,
      required var user,
      required String uid}) async {
    return await _firebaseFirestore
        .collection('users')
        .doc(uid)
        .set(user)
        .then((value) {
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
  }

  Future<bool> updateUser({
    required var data,
  }) async {
    var token = FirebaseAuth.instance.currentUser!.uid;
    return await _firebaseFirestore
        .collection('users')
        .doc(token)
        .update(data)
        .then((value) {
      fitchUserData();
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
  }

  Future<bool> checkExists(
      {required String collection, required String doc}) async {
    var a = await _firebaseFirestore.collection(collection).doc(doc).get();
    if (a.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fitchUserData() async {
    var token = FirebaseAuth.instance.currentUser!.uid;
    var data;
    final DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(token);
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      data = snapshot.data() as Map<String, dynamic>;
      AppController.to.loginMap.assignAll(data);
      print(data);
    });
    return true;
  }

  Future<String> uploadFile(
      {required File imageFile, required String fileName}) async {
    Reference reference;
    reference = FirebaseStorage.instance.ref().child(fileName);
    TaskSnapshot storageTaskSnapshot = await reference.putFile(imageFile);
    String dowUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return dowUrl;
  }

  Future<bool> createDocument(
      {required String nameCollection,
        required var data,
        required String uid}) async {
    return await _firebaseFirestore
        .collection(nameCollection)
        .doc(uid)
        .set(data)
        .then((value) {
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
  }

  Future<bool> updateDocument(
      {required String nameCollection,
        required var data,
        required String uid}) async {
    return await _firebaseFirestore
        .collection(nameCollection)
        .doc(uid)
        .update(data)
        .then((value) {
      return true;
    }).catchError((error) {
      print(error);
      return false;
    });
  }

  Future<bool> updateArray(
      {required String nameDoc, required List<String> data , required String nameCollection , required String nameList}) async {
    return await _firebaseFirestore
        .collection(nameCollection)
        .doc(nameDoc)
        .update({nameList: FieldValue.arrayUnion(data)})
        .then((value) => true)
        .catchError((error) => false);
  }
}
