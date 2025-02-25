import 'package:get/get.dart';

import '../helpers/helpers.dart';

mixin UISuccessManager on GetxController {
  final _mainSuccess = Rx<UISuccess?>(null);

  Stream<UISuccess?> get mainSuccessStream => _mainSuccess.stream;

  set mainSuccess(UISuccess? value) => _mainSuccess.value = value;
}
