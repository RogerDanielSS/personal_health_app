import 'package:get/get.dart';

mixin NavigationManager {
  void handleNavigation(
    Stream<String?> stream) {
    stream.listen((page) {
      if (page != null && page.isNotEmpty) {
        if (page.split('/').length == 2) {
          Get.offAllNamed(page);
        } else {
          Get.toNamed(page);
        }
      }
    });
  }
}
