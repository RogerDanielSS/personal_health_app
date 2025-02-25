import 'package:get/get.dart';

import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/pages/home_page_presenter.dart';

import '../../../domain/usecases/usecases.dart';
import '../../domain/helpers/domain_error.dart';
import '../helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxHomePagePresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements HomePagePresenter {
  final LoadEvents loadEvents;
  final DeleteCurrentAccount deleteCurrentAccount;
  final LoadCurrentAccount loadCurrentAccount;

  final _events = Rx<List<EventEntity>>([]);
  final _eventsError = Rx<String>('');
  final _selectedEvent = Rx<EventEntity?>(null);

  GetxHomePagePresenter({
    required this.loadEvents,
    required this.deleteCurrentAccount,
    required this.loadCurrentAccount,
  });

  @override
  Stream<EventEntity?> get selectedEventStream => _selectedEvent.stream;
  @override
  Stream<List<EventEntity>> get eventsStream => _events.stream;

  @override
  Future<void> loadEventsData() async {
    try {
      mainError = null;
      _eventsError.value = '';

      final events = await loadEvents.load();
      _events.value = events
          .map((event) => EventEntity(
              id: event.id, title: event.title, column1: event.column1))
          .toList();
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        setError();
      }
    } on Error {
      setError();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await deleteCurrentAccount.delete();
      navigateTo = '/login';
    } on Error {
      mainError = UIError.unexpected;
    }
  }

  void setError() {
    _eventsError.value = UIError.unexpected.description;
    _events.refresh();
  }
}
