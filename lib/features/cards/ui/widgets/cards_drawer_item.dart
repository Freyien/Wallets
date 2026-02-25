import 'package:flutter/material.dart';

class CardsDrawerItem extends StatelessWidget {
  const CardsDrawerItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  });

  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected ? Color(0xffDCE7C7) : Colors.transparent;
    final fontWeight = isSelected ? FontWeight.w600 : FontWeight.w400;

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: fontWeight,
          letterSpacing: 0.1,
        ),
      ),
      onTap: onTap,
      tileColor: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
