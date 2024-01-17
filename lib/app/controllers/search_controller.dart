import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilproje/app/controllers/home_controller.dart';

class SearchPageController extends GetxController {
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    HomeController c = Get.put(HomeController());
    c.getPosts();
    super.onInit();
  }

  List<DocumentSnapshot>? documents;
  Future<List<DocumentSnapshot>> searchPosts(String searchText) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      CollectionReference postsCollection = firestore.collection('posts');

      QuerySnapshot querySnapshot = await postsCollection.where('postText', isGreaterThanOrEqualTo: searchText).get();

      update();
      return documents = querySnapshot.docs;
    } catch (e) {
      debugPrint('Hata oluştu: $e');
      return [];
    }
  }
}
