import 'package:flutter/material.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });
  final String text;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: InkWell(
          onTap: onTap,
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xff394929),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
