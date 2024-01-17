import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobilproje/core/color_manager.dart';
import '../../../controllers/myads_controller.dart';

class MyadsPage extends GetView<MyadsController> {
  const MyadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager().primary,
        title: Text(
          'İlanlarım',
          style: TextStyle(color: ColorManager().secondary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: GetBuilder<MyadsController>(
        init: MyadsController(),
        builder: (c) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  c.myAdsList == null || c.myAdsList?.isEmpty == true
                      ? const Center(
                          child: Text(
                          "Henüz paylaştığın bir ilan yok.",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ))
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                          child: ListView.builder(
                            itemCount: c.myAdsList?.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
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
                                      Stack(
                                        children: [
                                          c.myAdsList?[index]["postPicture"] == null
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: ColorManager().primary,
                                                  ),
                                                  width: Get.width,
                                                  height: 250,
                                                )
                                              : CachedNetworkImage(
                                                  imageUrl: c.myAdsList?[index]["postPicture"],
                                                  fit: BoxFit.cover,
                                                  width: Get.width,
                                                  height: 250,
                                                ),
                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    try {
                                                      c.showEditDialog(context, index);
                                                    } catch (e) {
                                                      debugPrint(e.toString());
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: ColorManager().white,
                                                    ),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: ColorManager().black,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    try {
                                                      await c.removePosts(index);
                                                      await c.getAds();
                                                    } catch (e) {
                                                      debugPrint(e.toString());
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: ColorManager().white,
                                                    ),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: ColorManager().black,
                                                      size: 24.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 12,
                                          left: 4,
                                          bottom: 12,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              c.myAdsList?[index]["postText"],
                                              style: TextStyle(
                                                color: ColorManager().black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                            Text(
                                              c.myAdsList?[index]["price"],
                                              style: TextStyle(
                                                color: ColorManager().black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 17,
                                              ),
                                            ),
                                             Text(
                                            c.myAdsList?[index]['categories'],
                                            style: TextStyle(
                                              color: ColorManager().black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 17,
                                            ),
                                          ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 6, bottom: 6),
                                          child: Text(
                                            DateFormat('dd/MM/yyyy HH:mm').format(
                                              DateTime.fromMillisecondsSinceEpoch(
                                                c.myAdsList?[index]["timestamp"],
                                              ),
                                            ),
                                            style: TextStyle(
                                              color: ColorManager().black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
