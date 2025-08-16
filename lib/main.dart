import 'package:flutter/material.dart';
import 'package:personal_health_app/main/factories/pages/create_item_page/create_item_page_factory.dart';
import 'package:personal_health_app/main/factories/usecases/usecases.dart';

import 'main/factories/pages/home_page/home_page_factory.dart';
import 'presentation/components/main_layout.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.yellow),
      // LoginPage is the initial route
      home: LoginPage(
        authentication: makeRemoteAuthentication(),
        saveCurrentAccount: makeLocalSaveCurrentAccount(),
      ),
      // Named routes for post-login screens
      routes: {
        '/home': (context) => MainLayout(loadCurrentAccount: makeLocalLoadCurrentAccount(), child: makeHomePage()),
        '/profile': (context) =>
            MainLayout(loadCurrentAccount: makeLocalLoadCurrentAccount(), child: makeHomePage()),
        '/create_item': (context) =>
            MainLayout(loadCurrentAccount: makeLocalLoadCurrentAccount(), child: makeCreateItemPage()),
      },
    );
  }
}
