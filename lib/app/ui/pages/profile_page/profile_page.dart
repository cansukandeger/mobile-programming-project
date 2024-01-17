import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilproje/app/ui/global_widgets/textformfield.dart';
import '../../../../core/color_manager.dart';
import '../../../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager().primary,
        title: Text(
          'Profil',
          style: TextStyle(color: ColorManager().secondary, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: GetBuilder<ProfileController>(
              init: ProfileController(),
              builder: (c) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                      ),
                      child: TextFormFieldApp.instance.widget(
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.fromLTRB(
                            12,
                            4,
                            4,
                            6,
                          ),
                          focusColor: ColorManager().greyBG,
                          fillColor: ColorManager().greyBG,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager().greyBG,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager().greyBG,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager().greyBG,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: ColorManager().white,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: ColorManager().darkGray.withOpacity(0.6),
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: ColorManager().darkGray),
                        context: context,
                        controller: c.usernameController..text = c.userSnapshot?.data()?["username"] ?? "",
                        labelText: "Kullanıcı Adı",
                        maxLines: 1,
                        readOnly: true,
                        enabled: false,
                        validation: (val) {
                          if (val!.isEmpty) {
                            return "Lütfen bu alanı doldurunuz.";
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      child: TextFormFieldApp.instance.widget(
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: const EdgeInsets.fromLTRB(
                            12,
                            4,
                            4,
                            6,
                          ),
                          focusColor: ColorManager().greyBG,
                          fillColor: ColorManager().greyBG,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager().greyBG,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager().greyBG,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorManager().greyBG,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              width: 1.5,
                              color: ColorManager().white,
                            ),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: ColorManager().darkGray.withOpacity(0.6),
                          ),
                        ),
                        style: TextStyle(fontSize: 16, color: ColorManager().darkGray),
                        context: context,
                        controller: c.emailContoller..text = c.userSnapshot?.data()?["email"] ?? "",
                        labelText: "E-Posta",
                        maxLines: 1,
                        readOnly: true,
                        enabled: false,
                        validation: (val) {
                          if (val!.isEmpty) {
                            return "Lütfen bu alanı doldurunuz.";
                          }

                          return null;
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorManager().darkGray,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(6))),
                        child: Text(
                          'Çıkış Yap',
                          style: TextStyle(
                            color: ColorManager().darkGray,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
