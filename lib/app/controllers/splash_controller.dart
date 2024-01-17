import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigateToRootPage();
    super.onInit();
  }

  navigateToRootPage() {
    Future.delayed(
      const Duration(seconds: 2),
      () => Get.offAllNamed("/login"),
    );
  }
}