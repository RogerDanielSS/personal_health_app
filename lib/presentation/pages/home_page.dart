import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/domain/entities/item.dart';
import 'package:personal_health_app/domain/entities/user.dart';
import 'package:personal_health_app/domain/usecases/load_current_account.dart';
import 'package:personal_health_app/domain/usecases/load_user_items.dart';
import 'package:personal_health_app/presentation/components/events_list.dart';
import 'package:personal_health_app/presentation/components/loadings/circular_loading.dart';
import 'package:personal_health_app/presentation/pages/home_page_presenter.dart';

class HomePage extends StatefulWidget {
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
  UserEntity? _currentAccount;
  List<ItemEntity>? _items;
  bool _isLoading = true; // Add loading state
  String? _errorMessage; // Add error state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePage();
    });
  }

  Future<void> _initializePage() async {
    widget.presenter.loadItemsData();
    widget.presenter.loadCategoriesData();
    await _loadCurrentAccount();
  }

  Future<void> _loadCurrentAccount() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final account = await widget.loadCurrentAccount.load();

      setState(() {
        _currentAccount = account;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load account';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load account: ${e.toString()}')),
      );
    }
  }

  List<PopupMenuItem> getMenuItems(List<CategoryEntity> categories) {
    return categories.map((category) => PopupMenuItem(value: category.id, child: Text(category.name),)).toList();
  }

void _showScrollableMenu(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final renderObject = _fabKey.currentContext?.findRenderObject();
    if (renderObject == null || !(renderObject is RenderBox)) return;

    final fabRenderBox = renderObject as RenderBox;
    final fabSize = fabRenderBox.size;
    final fabOffset = fabRenderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        fabOffset.dx,
        fabOffset.dy - MediaQuery.of(context).size.height * 0.3,
        fabOffset.dx + fabSize.width,
        fabOffset.dy + fabSize.height,
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.3,
        maxWidth: 250,
      ),
      items: [
        // Show loading while waiting for data
        PopupMenuItem(
          child: StreamBuilder<List<CategoryEntity>>(
            stream: widget.presenter.categoriesStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No categories available');
              }
              return Column(
                children: getMenuItems(snapshot.data!),
              );
            },
          ),
        ),
      ],
    );
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: widget.presenter.itemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                ItemsList(
                  items: snapshot.data!,
                ),
              ],
            );
          }

          return const CircularLoading();
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: _fabKey,
        onPressed: () => _showScrollableMenu(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
