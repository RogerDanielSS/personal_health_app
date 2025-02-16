import 'package:flutter/material.dart';

import 'bottom_bar/animated_bottom_bar.dart';
import 'bottom_bar/bottom_bar_item.dart';

Widget text(String text) {
  return Text(text, style: const TextStyle(fontSize: 12));
}

Widget buildBottomBar({
  required int currentIndex,
  required void Function(int index) update,
  required BuildContext context,
}) {
  const inactiveColor = Colors.grey;

  return AnimatedBottomBar(
    containerHeight: 70,
    backgroundColor: Colors.white,
    selectedIndex: currentIndex,
    showElevation: true,
    itemCornerRadius: 24,
    curve: Curves.easeIn,
    onItemSelected: update,
    items: <BottomBarItem>[
      BottomBarItem(
        icon: const Icon(Icons.account_circle_outlined),
        title: text('Perfil'),
        activeColor: Theme.of(context).primaryColorLight,
        inactiveColor: inactiveColor,
        textAlign: TextAlign.center,
      ),
      BottomBarItem(
        icon: const Icon(Icons.query_stats_outlined),
        title: text('Produção'),
        activeColor: Theme.of(context).primaryColorLight,
        inactiveColor: inactiveColor,
        textAlign: TextAlign.center,
      ),
      BottomBarItem(
        icon: const Icon(Icons.donut_large_outlined),
        title: text('Dashboard'),
        activeColor: Theme.of(context).primaryColorLight,
        inactiveColor: inactiveColor,
        textAlign: TextAlign.center,
      ),
      BottomBarItem(
        icon: const Icon(Icons.currency_exchange),
        title: text('Antecipação'),
        activeColor: Theme.of(context).primaryColorLight,
        inactiveColor: inactiveColor,
        textAlign: TextAlign.center,
      ),
      BottomBarItem(
        icon: const Icon(Icons.calendar_month_outlined),
        title: text('Agenda'),
        activeColor: Theme.of(context).primaryColorLight,
        inactiveColor: inactiveColor,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
