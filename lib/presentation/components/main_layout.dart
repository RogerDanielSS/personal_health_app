// main_layout.dart
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const MainLayout({
    required this.child,
    this.title = 'App',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0, // Update this dynamically based on route
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 1) Navigator.pushNamed(context, '/profile');
        },
      ),
      body: child, // This renders the current page (e.g., HomePage)
    );
  }
}