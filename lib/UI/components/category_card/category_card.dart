import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity? category;
  final void Function()? onPressed;

  const CategoryCard({super.key, this.category, this.onPressed});

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');

    if (hex.length == 6) {
      hex = 'FF$hex';
    }

    return Color(int.parse(hex, radix: 16));
  }

  Color getContrastColor(String hexColor) {
    Color color = hexToColor(hexColor);

    double luminance = color.computeLuminance();

    return luminance > 0.5 ? Colors.black : Colors.white;
  }

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
