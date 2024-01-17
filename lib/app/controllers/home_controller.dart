import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  @override
  void onInit() {
    getPosts();
    super.onInit();
  }

  List<Map<dynamic, dynamic>> postsList = [];

  Future getPosts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('posts').orderBy('timestamp').limit(searchPageSize).get();

    if (snapshot.docs.isNotEmpty) {
      postsList = [];
      Set<int> existingTimestamps = Set<int>.from(postsList.map((post) => post['timestamp']));

      for (var doc in snapshot.docs) {
        Map<dynamic, dynamic> value = doc.data();

        if (!existingTimestamps.contains(value['timestamp'])) {
          postsList.add(value);
        }
      }

      postsList = postsList.reversed.toList();
    }

    update();
  }

  int searchPageSize = 10;

  getMoreUsers() {
    searchPageSize += searchPageSize + 10;
    getPosts();
  }


Future<void> applyToPost(int postId, String applicantUid) async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference postsCollection = firestore.collection('posts');
    DocumentReference postDocument = postsCollection.doc("$postId");
    CollectionReference usersCollection = firestore.collection('users');
    DocumentReference applicantDocument = usersCollection.doc(applicantUid);

    CollectionReference appliedCollection = postDocument.collection('applied');
    DocumentReference appliedDocument = appliedCollection.doc(applicantUid);

    DocumentSnapshot applicantSnapshot = await applicantDocument.get();

    if (applicantSnapshot.exists) {

      String applicantUsername = applicantSnapshot.get('username');
      String applicantUid = applicantSnapshot.get('uid');
      await appliedDocument.set({
        'uid': applicantUid,
        'username': applicantUsername,
        'did': applicantUid,
        'applicationTime': FieldValue.serverTimestamp(),
      });

      debugPrint('Başvuru başarıyla tamamlandı.');
    } else {
      debugPrint('Başvuran kullanıcının bilgileri bulunamadı.');
    }
  } catch (e) {
    debugPrint('Hata oluştu: $e');
  }
}

}
