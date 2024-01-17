import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobilproje/core/color_manager.dart';
import '../../../controllers/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (c) {
        return Scaffold(
          backgroundColor: ColorManager().primary,
          body: SafeArea(
            child: Center(
              child: Image.asset(
                "assets/logo.jpeg",
                width: 250,
              ),
            ),
          ),
        );
      },
    );
  }
}
