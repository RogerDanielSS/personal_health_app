import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/item.dart';

class ItemCard extends StatelessWidget {
  final ItemEntity? item;

  const ItemCard({
    super.key,
    this.item,
  });

  // List<Widget> buildCardFields() {
  //   var fields = item?.fields;
  //   if (fields == null) return [];

  //   return fields.entries.map((entry) {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           entry.key,
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         Text(entry.value.toString()), // Ensure value is converted to String
  //       ],
  //     );
  //   }).toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      color: Colors.blue[100],
      child: Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item?.title ?? "No Title",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              // ...buildCardFields(), // Insert list of Rows here
            ],
          ),
        ),
      ),
    );
  }
}
