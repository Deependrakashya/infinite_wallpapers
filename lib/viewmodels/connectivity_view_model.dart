import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityViewModel extends GetxController {
  RxBool disconnected = false.obs;
  late final StreamSubscription<InternetStatus> _subscription;

  @override
  void onInit() {
    super.onInit();
    checkInternet();
  }

  void checkInternet() async {
    log('Checking internet access...');

    // Initial check
    bool result = await InternetConnection().hasInternetAccess;
    disconnected.value = !result;

    // Listen for changes
    _subscription =
        InternetConnection().onStatusChange.listen((InternetStatus status) {
      switch (status) {
        case InternetStatus.connected:
          log('Internet connected');
          disconnected.value = false;
          break;
        case InternetStatus.disconnected:
          log('Internet disconnected');
          disconnected.value = true;
          break;
      }
    });
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
