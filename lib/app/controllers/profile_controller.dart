
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
 @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }

  DocumentSnapshot<Map<String, dynamic>>? userSnapshot;

  getUserInfo() async {
    userSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    update();
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailContoller = TextEditingController();
}
  