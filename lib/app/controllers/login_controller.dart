import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class LoginController extends GetxController {
  PageController pageController = PageController();
  bool showPasswordForLogin = true;
  bool showPasswordForRegister = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController emailControllerForLogin = TextEditingController();
  TextEditingController passwordControllerForLogin = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  login() async {
    try {
      if (loginFormKey.currentState!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailControllerForLogin.text,
          password: passwordControllerForLogin.text,
        );
      }
    } on FirebaseAuthException catch (e) {
      Get.closeAllSnackbars();
      final translator = GoogleTranslator();
      Translation translation = await translator.translate(e.message ?? "", to: 'tr');
      Get.snackbar("Error", translation.text, backgroundColor: Colors.white);
    }
  }

  register() async {
    if (registerFormKey.currentState!.validate()) {
      try {
        UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        if (credential.user?.email != null) {
          await FirebaseFirestore.instance.collection("users").doc(credential.user?.uid).set(
            {
              "username": usernameController.text,
              "email": emailController.text,
              "uid": credential.user?.uid,
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        Get.closeAllSnackbars();
        final translator = GoogleTranslator();
        Translation translation = await translator.translate(e.message ?? "", to: 'tr');
        Get.snackbar("Error", translation.text, backgroundColor: Colors.white);
      } finally {}
    }
  }
}
