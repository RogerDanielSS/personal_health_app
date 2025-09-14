import 'package:flutter/material.dart';
import 'package:personal_health_app/UI/mixins/navigation_manager.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/domain/usecases/load_current_account.dart';
import 'package:personal_health_app/UI/components/items_cards_list/items_list.dart';
import 'package:personal_health_app/UI/components/loadings/circular_loading.dart';
import 'package:personal_health_app/UI/pages/home/home_page_presenter.dart';

class HomePage extends StatefulWidget with NavigationManager {
  final HomePagePresenter presenter;
  final LoadCurrentAccount loadCurrentAccount;
  // final LoadUserItems loadUserItems;

  const HomePage(
      {super.key, required this.presenter, required this.loadCurrentAccount});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _fabKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePage();
    });
  }

  Future<void> _initializePage() async {
    widget.presenter.loadItemsData();
  }

  List<PopupMenuItem> getMenuItems(List<CategoryEntity> categories) {
    return categories
        .map((category) => PopupMenuItem(
              value: category.id,
              child: Text(category.name),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      widget.handleNavigation(widget.presenter.navigateToStream);

      return Scaffold(
        body: StreamBuilder(
          stream: widget.presenter.itemsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ItemsList(
                      items: snapshot.data!,
                    ),
                  ],
                ),
              );
            }

            return const CircularLoading();
          },
        ),
        floatingActionButton: FloatingActionButton(
          key: _fabKey,
          onPressed: widget.presenter.handleAddNewItem,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
