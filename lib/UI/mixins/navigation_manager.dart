import 'package:get/get.dart';

mixin NavigationManager {
  void handleNavigation(
    Stream<String?> stream) {
    stream.listen((page) {
      if (page != null && page.isNotEmpty) {
        var temp = page.split('/').length;

        if (page.split('/').length == 2 || page =='/') {
          Get.offAllNamed(page);
        } else {
          Get.toNamed(page);
        }
      }
    });
  }
}
