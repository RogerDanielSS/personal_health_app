import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

import '../../mixins/color_helper.dart';

class CategoryCard extends StatelessWidget with ColorHelper {
  final CategoryEntity? category;
  final void Function()? onPressed;

  const CategoryCard({super.key, this.category, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      color: hexToColor(category?.color ?? '#808080'),
      child: InkWell(
        onTap: onPressed,
        borderRadius:
            BorderRadius.circular(4), // Match Card's default borderRadius
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              category?.name ?? "",
              style: TextStyle(
                color: getContrastColor(category?.color ?? '#808080'),
                decorationColor: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
