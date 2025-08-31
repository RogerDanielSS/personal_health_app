import 'package:get/get.dart';
import 'package:personal_health_app/UI/components/main_layout/main_layout_presenter.dart';
import '../mixins/mixins.dart';

class GetxMainLayoutPresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements MainLayoutPresenter {
}
