import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:personal_health_app/main/factories/pages/create_item_page_factory.dart';
import 'package:personal_health_app/main/factories/pages/login_page_factory.dart';
import 'package:personal_health_app/main/factories/presenters/main_layout_presenter_factory.dart';
import 'package:personal_health_app/main/factories/usecases/usecases.dart';

import 'main/factories/pages/home_page_factory.dart';
import 'UI/components/main_layout/main_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'), // Brazilian Portuguese
      ],
      debugShowCheckedModeBanner: false,
      title: 'Minha saúde',
      theme: ThemeData(primarySwatch: Colors.yellow),
      // LoginPage is the initial route
      home: makeLoginPage(),
      // Named routes for post-login screens
      getPages: [
        GetPage(
          name: '/home',
          page: () => MainLayout(
            presenter: makeGetxMainLayoutPresenter(),
            loadCurrentAccount: makeLocalLoadCurrentAccount(),
            child: makeHomePage(),
          ),
        ),
        GetPage(
          name: '/profile',
          page: () => MainLayout(
            presenter: makeGetxMainLayoutPresenter(),
            loadCurrentAccount: makeLocalLoadCurrentAccount(),
            child: makeHomePage(),
          ),
        ),
        GetPage(
          name: '/create_item',
          page: () => MainLayout(
            presenter: makeGetxMainLayoutPresenter(),
            loadCurrentAccount: makeLocalLoadCurrentAccount(),
            child: makeCreateItemPage(),
          ),
        ),
      ],
    );
  }
}