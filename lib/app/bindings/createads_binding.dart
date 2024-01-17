
import 'package:get/get.dart';
import '../controllers/createads_controller.dart';


class CreateadsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateadsController>(() => CreateadsController());
  }
}