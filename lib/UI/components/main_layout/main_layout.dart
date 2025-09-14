// main_layout.dart
import 'package:flutter/material.dart';
import 'package:personal_health_app/UI/components/main_layout/main_layout_presenter.dart';
import 'package:personal_health_app/UI/mixins/navigation_manager.dart';
import 'package:personal_health_app/domain/entities/user.dart';
import 'package:personal_health_app/domain/usecases/load_current_account.dart';

class MainLayout extends StatefulWidget with NavigationManager {
  final LoadCurrentAccount loadCurrentAccount;
  final Widget child;
  final MainLayoutPresenter presenter;

  const MainLayout(
      {super.key,
      required this.loadCurrentAccount,
      required this.child,
      required this.presenter});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePage();
    });
  }

  Future<void> _initializePage() async {
    widget.presenter.loadCurrentAccountData();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      widget.handleNavigation(widget.presenter.navigateToStream);

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: StreamBuilder<UserEntity?>(
            stream: widget.presenter.currentAccountStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data?.name ?? '');
              } else {
                return Text('');
              }
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: widget.presenter.logout,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: 0, // Update this dynamically based on route
          onTap: (index) {
            if (index == 0) Navigator.pushNamed(context, '/item');
            if (index == 1) Navigator.pushNamed(context, '/profile');
          },
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            image: DecorationImage(
              image:
                  AssetImage('assets/background_1920x1080.png'), // Local image
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: Container(
              constraints: BoxConstraints(maxWidth: 900), child: widget.child),
        ),
      );
    });
  }
}
