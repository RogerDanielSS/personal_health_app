import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/components/build_bottom_bar.dart';
import 'package:personal_health_app/presentation/components/events_list.dart';

import '../components/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Saúde'),
      ),
      body: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            EventsList(
              events: [
                EventEntity(id: 1, title: 'Teste', column1: 'Arroba'),
                EventEntity(id: 2, title: 'Teste2', column1: 'Arroba2'),
                EventEntity(id: 3, title: 'Teste3', column1: 'Arroba3'),
                EventEntity(id: 4, title: 'Teste4', column1: 'Arroba4')
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
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
