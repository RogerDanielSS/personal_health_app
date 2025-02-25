import 'package:get/get.dart';

mixin GobackNavigationManager on GetxController {
  final _goBackTo = Rx<String?>(null);

  Stream<String?> get goBackToStream => _goBackTo.stream;

  set goBackTo(String value) => _goBackTo.subject.add(value);
}
