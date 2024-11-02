import 'package:get/get.dart';

class MyController extends GetxController {
  RxBool getTouch = false.obs;

  void toggleSearchBar() {
    if (getTouch.value) {
      getTouch.value = false;
    } else {
      getTouch.value = true;
    }
  }
}
