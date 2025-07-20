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
        icon: const Icon(Icons.view_agenda),
        title: text('Notas'),
        activeColor: Theme.of(context).primaryColorLight,
        inactiveColor: inactiveColor,
        textAlign: TextAlign.center,
      ),
      BottomBarItem(
        icon: const Icon(Icons.list),
        title: text('Categorias'),
        activeColor: Theme.of(context).primaryColorLight,
        inactiveColor: inactiveColor,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
