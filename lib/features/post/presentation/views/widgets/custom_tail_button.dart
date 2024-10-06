import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';

class CustomTailButton extends StatelessWidget {
  const CustomTailButton({
    super.key,
    this.onTap,
    required this.icon,
    required this.text,
    this.color,
    this.iconColor = Colors.black,
  });
  final void Function()? onTap;
  final IconData icon;
  final String text;
  final Color? color;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          hGap(8),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
