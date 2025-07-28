import 'package:flutter/material.dart';
import 'package:personal_health_app/main/factories/usecases/usecases.dart';

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
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: LoginPage(
        authentication: makeRemoteAuthentication(),
        saveCurrentAccount: makeLocalSaveCurrentAccount(),
      ),
    );
  }
}
