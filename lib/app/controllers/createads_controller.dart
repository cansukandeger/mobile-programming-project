import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobilproje/app/controllers/home_controller.dart';
import 'package:mobilproje/app/controllers/myads_controller.dart';
import 'package:uuid/uuid.dart';

class CreateadsController extends GetxController {
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  XFile? image;

  pickUploadImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 10);
    update();
  }

  TextEditingController postController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  String dropdownValue = "Kategori Seçiniz";

  Map<dynamic, dynamic> user = {};

  Future<void> getUser() async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    if (userSnapshot.exists) {
      Map<dynamic, dynamic>? userData = userSnapshot.data();

      if (userData != null) {
        user = userData;
      }

      update();
    }
  }

  void sharePost(BuildContext context) async {
    String downloadUrl = "";
    if (image != null) {
      var uuid = const Uuid();
      String filename = uuid.v1();
      Reference ref = FirebaseStorage.instance.ref().child(filename);
      await ref.putFile(File(image!.path));
      downloadUrl = await FirebaseStorage.instance.ref(filename).getDownloadURL();

      if (downloadUrl.isNotEmpty && dropdownValue != "Kategori Seçiniz" && postController.text.isNotEmpty && priceController.text.isNotEmpty) {
        int now = DateTime.now().millisecondsSinceEpoch;

        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('posts').doc('$now').set(
          {
            "timestamp": now,
            "postPicture": downloadUrl,
            "postText": postController.text,
            "price": priceController.text,
            "categories": dropdownValue,
          },
        );

        await FirebaseFirestore.instance.collection('posts').doc('$now').set(
          {
            "timestamp": now,
            "postPicture": downloadUrl,
            "postText": postController.text,
            "price": priceController.text,
            "categories": dropdownValue,
            "username": user["username"],
            "uid": user["uid"],
          },
        );

        HomeController homeController = Get.find();
        await homeController.getPosts();
        MyadsController myadsController = Get.find();
        myadsController.getAds();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }
}
