import 'package:flutter/material.dart';
import 'package:personal_health_app/presentation/helpers/errors/ui_error.dart';

import '../components/components.dart';

mixin UIErrorManager {
  void handleMainError(BuildContext context, Stream<UIError?> stream) {
    stream.listen((error) {
      if (error != null) {
        showErrorMessage(context, error.description);
      }
    });
  }
}
