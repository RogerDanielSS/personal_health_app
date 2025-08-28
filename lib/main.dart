import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:personal_health_app/main/factories/pages/create_item_page/create_item_page_factory.dart';
import 'package:personal_health_app/main/factories/pages/login_page/login_page_factory.dart';
import 'package:personal_health_app/main/factories/presenters/main_layout_presenter_factory.dart';
import 'package:personal_health_app/main/factories/usecases/usecases.dart';

import 'main/factories/pages/home_page/home_page_factory.dart';
import 'UI/components/main_layout/main_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'), // Brazilian Portuguese
      ],
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.yellow),
      // LoginPage is the initial route
      home: makeLoginPage(),
      // Named routes for post-login screens
      routes: {
        '/home': (context) => MainLayout(
            presenter: makeGetxMainLayoutPresenter(),
            loadCurrentAccount: makeLocalLoadCurrentAccount(),
            child: makeHomePage()),
        '/profile': (context) => MainLayout(
            presenter: makeGetxMainLayoutPresenter(),
            loadCurrentAccount: makeLocalLoadCurrentAccount(),
            child: makeHomePage()),
        '/create_item': (context) => MainLayout(
            presenter: makeGetxMainLayoutPresenter(),
            loadCurrentAccount: makeLocalLoadCurrentAccount(),
            child: makeCreateItemPage()),
      },
    );
  }
}
