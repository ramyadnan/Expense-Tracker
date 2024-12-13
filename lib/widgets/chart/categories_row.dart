import 'package:flutter/material.dart';

class CategoriesRow extends StatelessWidget {
  const CategoriesRow({
    super.key,
    required this.icon,
    required this.color,
    required this.category,
  });

  final IconData icon;
  final Color color;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: color,
            size: 25,
          ),
          const SizedBox(width: 16),
          Text( '${category[0].toUpperCase()}${category.substring(1).toLowerCase()}'),
        ],
      ),
    );
  }
}
