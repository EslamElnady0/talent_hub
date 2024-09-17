import 'package:flutter/material.dart';

class UserImageCircleAvatar extends StatelessWidget {
  final double? radius;
  final String image;
  const UserImageCircleAvatar({super.key, this.radius, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage(image),
    );
  }
}
