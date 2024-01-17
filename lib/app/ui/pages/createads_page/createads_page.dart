import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilproje/app/ui/global_widgets/button.dart';
import 'package:mobilproje/app/ui/global_widgets/textformfield.dart';
import 'package:mobilproje/core/color_manager.dart';
import '../../../controllers/createads_controller.dart';

class CreateadsPage extends GetView<CreateadsController> {
  const CreateadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager().primary,
        title: Text(
          'İlan Paylaş',
          style: TextStyle(color: ColorManager().secondary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
        iconTheme: IconThemeData(color: ColorManager().secondary),
      ),
      body: GetBuilder<CreateadsController>(
        init: CreateadsController(),
        builder: (c) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), shape: BoxShape.rectangle, color: ColorManager().secondary, border: Border.all(color: ColorManager().primary, width: 1.3)),
                          child: c.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(c.image!.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        Positioned(
                          child: GestureDetector(
                            onTap: () {
                              c.pickUploadImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                                color: ColorManager().primary,
                                border: Border.all(
                                  color: ColorManager().primary,
                                  width: 1.3,
                                ),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: ColorManager().secondary,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: DropdownButton<String>(
                          value: c.dropdownValue,
                          icon: const Icon(Icons.list),
                          items: const [
                            DropdownMenuItem<String>(
                              value: "Kategori Seçiniz",
                              child: Text("Kategori Seçiniz"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Ev",
                              child: Text("Ev"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Bahçe",
                              child: Text("Bahçe"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Teknoloji",
                              child: Text("Teknoloji"),
                            ),
                            DropdownMenuItem<String>(
                              value: "Oyun & Oyuncak",
                              child: Text("Oyun & Oyuncak"),
                            ),
                          ],
                          onChanged: (value) {
                            c.dropdownValue = value ?? "";
                            c.update();
                          },
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: TextFormFieldApp.instance.widget(
                        style: TextStyle(fontSize: 16, color: ColorManager().black),
                        context: context,
                        controller: c.priceController,
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
                          labelText: "Fiyat Girin",
                        ),
                        maxLines: 2,
                        minLines: 2,
                        validation: (val) {
                          if (val!.isEmpty) {
                            return "Lütfen bu alanı doldurunuz.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: TextFormFieldApp.instance.widget(
                        style: TextStyle(fontSize: 16, color: ColorManager().black),
                        context: context,
                        controller: c.postController,
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
                          labelText: "İlan Metnini Girin",
                        ),
                        maxLines: 5,
                        minLines: 5,
                        validation: (val) {
                          if (val!.isEmpty) {
                            return "Lütfen bu alanı doldurunuz.";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Button(
                        height: 56,
                        color: ColorManager().primary,
                        title: "Paylaş",
                        textColor: ColorManager().white,
                        onTap: () async {
                          c.sharePost(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
