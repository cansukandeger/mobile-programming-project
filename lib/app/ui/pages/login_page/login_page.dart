import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilproje/app/ui/pages/root_page/root_page.dart';
import '../../../../core/color_manager.dart';
import '../../../controllers/login_controller.dart';
import '../../global_widgets/button.dart';
import '../../global_widgets/textformfield.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final isSignedIn = snapshot.data != null;
            if (isSignedIn) {
              return const RootPage();
            }
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.bottomCenter,
                  begin: Alignment.topCenter,
                  colors: [
                    ColorManager().primary,
                    ColorManager().primary.withOpacity(0.9),
                    ColorManager().primary.withOpacity(0.85),
                    ColorManager().primary.withOpacity(0.8),
                  ],
                ),
              ),
              child: SafeArea(
                child: GetBuilder<LoginController>(
                  init: LoginController(),
                  builder: (c) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8,
                          right: 8,
                          top: 16,
                        ),
                        child: SingleChildScrollView(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Column(
                            children: [
                              const Logo(),
                              ExpandablePageView(
                                controller: c.pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Form(
                                    key: c.registerFormKey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(24),
                                            child: Text(
                                              "Üye Ol",
                                              style: TextStyle(
                                                color: ColorManager().secondary,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          TextFormFieldApp.instance.widget(
                                            context: context,
                                            labelText: "Kullanıcı Adı",
                                            errorStyle: TextStyle(color: ColorManager().white),
                                            keyboardType: TextInputType.name,
                                            controller: c.usernameController,
                                            validation: (val) {
                                              if (val!.isEmpty) {
                                                return "Lütfen bu alanı doldurunuz.";
                                              }
                                              return null;
                                            },
                                            leadingIcon: Icon(
                                              Icons.account_circle,
                                              color: ColorManager().primary.withOpacity(0.6),
                                            ),
                                          ),
                                          TextFormFieldApp.instance.widget(
                                            context: context,
                                            labelText: "E-posta",
                                            errorStyle: TextStyle(color: ColorManager().white),
                                            keyboardType: TextInputType.emailAddress,
                                            controller: c.emailController,
                                            validation: (val) {
                                              if (val!.isEmpty) {
                                                return "Lütfen bu alanı doldurunuz.";
                                              }
                                              return null;
                                            },
                                            leadingIcon: Icon(
                                              Icons.email,
                                              color: ColorManager().primary.withOpacity(0.6),
                                            ),
                                          ),
                                          TextFormFieldApp.instance.widget(
                                            context: context,
                                            labelText: "Şifre",
                                            keyboardType: TextInputType.visiblePassword,
                                            controller: c.passwordController,
                                            errorStyle: TextStyle(color: ColorManager().white),
                                            obscureText: c.showPasswordForRegister,
                                            leadingIcon: Icon(
                                              Icons.lock,
                                              color: ColorManager().primary.withOpacity(0.6),
                                            ),
                                            validation: (val) {
                                              if (val!.isEmpty) {
                                                return "Lütfen bu alanı doldurunuz.";
                                              }
                                              if (val.length < 6) {
                                                return "Lütfen en az 6 karakter giriniz.";
                                              }
                                              return null;
                                            },
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                c.showPasswordForRegister == true ? Icons.visibility_off : Icons.visibility,
                                                color: ColorManager().darkGray.withOpacity(0.6),
                                              ),
                                              onPressed: () {
                                                c.showPasswordForRegister = !c.showPasswordForRegister;
                                                c.update();
                                              },
                                            ),
                                          ),
                                          Button(
                                            color: ColorManager().secondary,
                                            title: "Üye Ol",
                                            textColor: ColorManager().white.withOpacity(0.9),
                                            onTap: () async {
                                              await c.register();
                                            },
                                          ),
                                          InkWell(
                                            onTap: () {
                                              c.pageController.animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(18),
                                              child: Text(
                                                "Üyeliğiniz var mı? Giriş yapın",
                                                style: TextStyle(
                                                  color: ColorManager().white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: c.loginFormKey,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:const EdgeInsets.all(24,),
                                            child: Text(
                                              "Giriş Yap",
                                              style: TextStyle(
                                                color: ColorManager().secondary,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          TextFormFieldApp.instance.widget(
                                            context: context,
                                            labelText: "E-posta",
                                            keyboardType: TextInputType.emailAddress,
                                            errorStyle: TextStyle(color: ColorManager().white),
                                            validation: (val) {
                                              if (val!.isEmpty) {
                                                return "Lütfen bu alanı doldurunuz.";
                                              }
                                              return null;
                                            },
                                            controller: c.emailControllerForLogin,
                                            leadingIcon: Icon(Icons.email, color: ColorManager().primary.withOpacity(0.6)),
                                          ),
                                          TextFormFieldApp.instance.widget(
                                            context: context,
                                            controller: c.passwordControllerForLogin,
                                            keyboardType: TextInputType.visiblePassword,
                                            labelText: "Şifre",
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
                                            obscureText: c.showPasswordForLogin,
                                            leadingIcon: Icon(Icons.lock, color: ColorManager().primary.withOpacity(0.6)),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                c.showPasswordForLogin == true ? Icons.visibility_off : Icons.visibility,
                                                color: ColorManager().primary.withOpacity(0.6),
                                              ),
                                              onPressed: () {
                                                c.showPasswordForLogin = !c.showPasswordForLogin;
                                                c.update();
                                              },
                                            ),
                                          ),
                                          Button(
                                            color: ColorManager().secondary,
                                            title: "Giriş Yap",
                                            textColor: ColorManager().white.withOpacity(0.9),
                                            onTap: () async {
                                              await c.login();
                                            },
                                          ),
                                          InkWell(
                                            onTap: () {
                                              c.pageController.animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(18),
                                              child: Text(
                                                "Üyeliğiniz yok mu? Üye olun",
                                                style: TextStyle(
                                                  color: ColorManager().white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        "assets/logo.jpeg",
        width: Get.width / 2.6,
        height: Get.width / 2.6,
      ),
    );
  }
}