import 'package:flutter/material.dart';
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

  final List<PopupMenuItem> _menuItems = [
    const PopupMenuItem(
      value: "Hemograma",
      child: Text("Hemograma"),
    ),
    const PopupMenuItem(
      value: "Ressonância magnética",
      child: Text("Ressonância magnética"),
    ),
    const PopupMenuItem(
      value: "Ultrassom",
      child: Text("Ultrassom"),
    ),
    // Add more items...
  ];

  void _showScrollableMenu(BuildContext context) {
    // Get the RenderBox of the FloatingActionButton
    final RenderBox fabRenderBox = context.findRenderObject() as RenderBox;
    final fabSize = fabRenderBox.size;
    final fabOffset = fabRenderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        fabOffset.dx, // Left: same as FAB's left
        fabOffset.dy - 10, // Top: above FAB (with 10px padding)
        fabOffset.dx + fabSize.width, // Right: same as FAB's right
        fabOffset.dy + fabSize.height, // Bottom: below FAB (unused here)
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
        maxWidth: 250, // Optional: constrain width
      ),
      items: _menuItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_currentAccount?.name ?? ''),
      ),
      body: StreamBuilder(
        stream: widget.presenter.itemsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                mainAxisAlignment: MainAxisAlignment.center,
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
        onPressed: () => _showScrollableMenu(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
