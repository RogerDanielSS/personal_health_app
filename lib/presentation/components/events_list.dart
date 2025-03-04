import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/item.dart';
import 'package:personal_health_app/presentation/components/card.dart';

class ItemsList extends StatelessWidget {
  final List<ItemEntity>? items;

  const ItemsList({super.key, this.items});

  List<Widget> buildItemsCards(int count) {
    return List.generate(
        count,
        (index) => ItemCard(
              item: items![index],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        key: key,
        children: buildItemsCards((items ?? []).length),
      ),
    );
  }
}
