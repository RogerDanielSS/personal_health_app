import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/user.dart';
import 'package:personal_health_app/domain/usecases/load_current_account.dart';
import 'package:personal_health_app/presentation/components/build_bottom_bar.dart';
import 'package:personal_health_app/presentation/components/events_list.dart';
import 'package:personal_health_app/presentation/components/loadings/circular_loading.dart';
import 'package:personal_health_app/presentation/pages/home_page_presenter.dart';

class HomePage extends StatefulWidget {
  final HomePagePresenter presenter;
  final LoadCurrentAccount loadCurrentAccount;

  const HomePage(
      {super.key, required this.presenter, required this.loadCurrentAccount});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserEntity? _currentAccount;
  @override
  void initState() {
    super.initState();
    widget.presenter.loadItemsData();
    _loadCurrentAccount();
  }

  Future<void> _loadCurrentAccount() async {
    try {
      _currentAccount = await widget.loadCurrentAccount.load();
      print(_currentAccount);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load account: ${e.toString()}')),
      );
    }
  }

  void handleAddEvent() {
    print(widget.presenter.itemsStream);
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
        onPressed: handleAddEvent,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: buildBottomBar(
        currentIndex: 1,
        update: (index) => print(index),
        context: context,
      ),
    );
  }
}
