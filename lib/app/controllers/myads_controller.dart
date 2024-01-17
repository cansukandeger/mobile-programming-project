import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilproje/app/ui/global_widgets/button.dart';
import 'package:mobilproje/core/color_manager.dart';

import '../ui/global_widgets/textformfield.dart';

class MyadsController extends GetxController {
  List<Map<dynamic, dynamic>>? myAdsList = [];

  TextEditingController textController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  void showEditDialog(
    BuildContext context,
    int index,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorManager().primary,
          title: Text(
            'İlanını Güncelle',
            style: TextStyle(color: ColorManager().secondary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldApp.instance.widget(
                context: context,
                labelText: "İlan Metni",
                keyboardType: TextInputType.visiblePassword,
                controller: textController,
                errorStyle: TextStyle(color: ColorManager().white),
                validation: (val) {
                  if (val!.isEmpty) {
                    return "Lütfen bu alanı doldurunuz.";
                  }
                  if (val.length < 6) {
                    return "Lütfen en az 6 karakter giriniz.";
                  }
                  return null;
                },
              ),
              TextFormFieldApp.instance.widget(
                context: context,
                labelText: "İlan Fiyatı",
                keyboardType: TextInputType.visiblePassword,
                controller: priceController,
                errorStyle: TextStyle(color: ColorManager().white),
                validation: (val) {
                  if (val!.isEmpty) {
                    return "Lütfen bu alanı doldurunuz.";
                  }
                  if (val.length < 6) {
                    return "Lütfen en az 6 karakter giriniz.";
                  }
                  return null;
                },
              ),
              Button(
                textColor: ColorManager().darkGray,
                title: "Güncelle",
                color: ColorManager().secondary,
                onTap: () async {
                  if (textController.text.isNotEmpty && priceController.text.isNotEmpty) {
                    await updatePostText(index, textController.text, priceController.text);
                    textController.text = "";
                    priceController.text = "";
                    Get.back();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    getAds();
    super.onInit();
  }

  Future<void> getAds() async {
    CollectionReference<Map<String, dynamic>> collectionRef = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('posts');

    QuerySnapshot<Map<String, dynamic>> snapshot = await collectionRef.orderBy('timestamp').get();

    myAdsList = [];

    List<Map<String, dynamic>> values = snapshot.docs.map((doc) => doc.data()).toList();

    for (var value in values) {
      myAdsList?.add(value);
    }

    myAdsList = myAdsList?.reversed.toList();

    update();
  }

  Future removePosts(int index) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final String timestamp = myAdsList![index]["timestamp"].toString();
    await FirebaseFirestore.instance.collection('users').doc(uid).collection('posts').doc(timestamp).delete();
    await FirebaseFirestore.instance.collection('posts').doc(timestamp).delete();
  }

  Future updatePostText(int index, String newPostText, String priceText) async {
    final String uid = FirebaseAuth.instance.currentUser!.uid;
    final String timestamp = myAdsList![index]["timestamp"].toString();

    DocumentSnapshot userPostSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).collection('posts').doc(timestamp).get();

    DocumentSnapshot globalPostSnapshot = await FirebaseFirestore.instance.collection('posts').doc(timestamp).get();

    if (userPostSnapshot.exists && globalPostSnapshot.exists) {
      await FirebaseFirestore.instance.collection('users').doc(uid).collection('posts').doc(timestamp).update({'postText': newPostText, 'price': priceText});
      await FirebaseFirestore.instance.collection('posts').doc(timestamp).update({'postText': newPostText, 'price': priceText});
      await getAds();
    }
  }
}
