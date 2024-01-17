import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobilproje/app/ui/pages/createads_page/createads_page.dart';
import 'package:mobilproje/core/color_manager.dart';
import 'package:share_plus/share_plus.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager().primary,
        title: Text(
          'Anasayfa',
          style: TextStyle(color: ColorManager().secondary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const CreateadsPage());
            },
            icon: Icon(
              Icons.add_box,
              color: ColorManager().secondary,
            ),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (c) {
          return c.postsList.isEmpty
              ? const Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hiçbir gönderi bulunamadı.",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ))
              : RefreshIndicator(
                  onRefresh: () async {
                    await c.getMoreUsers();
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      width: Get.width,
                      color: ColorManager().grayBorder,
                    ),
                    itemCount: c.postsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorManager().black),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              c.postsList[index]['username'],
                                              style: TextStyle(
                                                color: ColorManager().black,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 6),
                                              child: Text(
                                                DateFormat('dd/MM/yyyy HH:mm').format(
                                                  DateTime.fromMillisecondsSinceEpoch(
                                                    c.postsList[index]['timestamp'],
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  color: ColorManager().black,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  c.postsList[index]['postPicture'] == null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorManager().primary,
                                          ),
                                          width: Get.width,
                                          height: 250,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: c.postsList[index]['postPicture'],
                                          fit: BoxFit.cover,
                                          width: Get.width,
                                          height: 250,
                                        ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 12,
                                  left: 4,
                                  bottom: 12,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            c.postsList[index]['postText'],
                                            style: TextStyle(
                                              color: ColorManager().black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                          Text(
                                            c.postsList[index]['price'],
                                            style: TextStyle(
                                              color: ColorManager().black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                           Text(
                                            c.postsList[index]['categories'],
                                            style: TextStyle(
                                              color: ColorManager().black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: InkWell(
                                              onTap: () async {
                                                Share.share(c.postsList[index]["postText"]);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  color: ColorManager().secondary,
                                                ),
                                                padding: const EdgeInsets.all(8),
                                                child: Text(
                                                  "Paylaş",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: ColorManager().darkGray,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              c.applyToPost(c.postsList[index]["timestamp"], FirebaseAuth.instance.currentUser!.uid);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: ColorManager().secondary,
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: Text(
                                                "Basvur",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorManager().darkGray,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Text(
                                "Teklif Gönderenler",
                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                              const Divider(),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection('posts').doc("${c.postsList[index]["timestamp"]}").collection('applied').snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }

                                  if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  }

                                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                    return const Text('Herhangi bir teklif yok.');
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      var applicationData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                                      return ListTile(
                                        leading: Text("${index + 1}"),
                                        title: Text(
                                          applicationData['username'] ?? "",
                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                                        ),
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
