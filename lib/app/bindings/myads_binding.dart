
import 'package:get/get.dart';
import '../controllers/myads_controller.dart';


class MyadsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyadsController>(() => MyadsController());
  }
}