import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/components/build_bottom_bar.dart';
import 'package:personal_health_app/presentation/components/events_list.dart';
import 'package:personal_health_app/presentation/pages/home_page_presenter.dart';

class HomePage extends StatefulWidget {
  final HomePagePresenter presenter;

  const HomePage({super.key, required this.presenter});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
