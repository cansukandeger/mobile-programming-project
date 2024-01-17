import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobilproje/app/controllers/home_controller.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/color_manager.dart';
import '../../../controllers/search_controller.dart';
import '../../global_widgets/textformfield.dart';

class SearchPage extends GetView<SearchPageController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      init: SearchPageController(),
      builder: (c) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorManager().primary,
            title: Text(
              'Arama Yap',
              style: TextStyle(color: ColorManager().secondary, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 1,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormFieldApp.instance.widget(
                  context: context,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(
                      12,
                      4,
                      4,
                      6,
                    ),
                    focusColor: ColorManager().primary,
                    fillColor: ColorManager().white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorManager().black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorManager().black,
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1,
                        color: ColorManager().black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 1.5,
                        color: ColorManager().black,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: ColorManager().black,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: ColorManager().black,
                    ),
                    labelText: "İlan İsmi Ara",
                  ),
                  errorStyle: TextStyle(color: ColorManager().white),
                  controller: c.searchController,
                  validation: (val) {
                    if (val!.isEmpty) {
                      return "Lütfen bu alanı doldurunuz.";
                    }
                    return null;
                  },
                  onFieldSubmitted: (val) async {
                    await c.searchPosts(val);
                    c.update();
                  },
                ),
              ),
              GetBuilder<HomeController>(
                init: HomeController(),
                builder: (c2) {
                  return Expanded(
                    child: (c.documents?.isNotEmpty == true)
                        ? ListView.builder(
                            itemCount: c.documents?.length,
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
                                                      c.documents?[index]['username'],
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
                                                            c.documents?[index]['timestamp'],
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
                                          c.documents?[index]['postPicture'] == null
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorManager().primary,
                                                  ),
                                                  width: Get.width,
                                                  height: 250,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: c.documents?[index]['postPicture'],
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
                                                    c.documents?[index]['postText'],
                                                    style: TextStyle(
                                                      color: ColorManager().black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    c.documents?[index]['price'],
                                                    style: TextStyle(
                                                      color: ColorManager().black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  Text(
                                                    c.documents?[index]['categories'],
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
                                                        Share.share(c.documents?[index]["postText"]);
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
                                                      c2.applyToPost(c.documents?[index]["timestamp"], FirebaseAuth.instance.currentUser!.uid);
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
                                        stream: FirebaseFirestore.instance.collection('posts').doc("${c2.postsList[index]["timestamp"]}").collection('applied').snapshots(),
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
                          )
                        : const Text('Arama sonucu bulunamadı.'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
