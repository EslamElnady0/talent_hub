import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserImageCircleAvatar extends StatelessWidget {
  final double? radius;
  final String? image;
  const UserImageCircleAvatar({super.key, this.radius, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: image != null
          ? CachedNetworkImageProvider(image!)
          : const AssetImage("assets/images/default_user.png"),
    );
  }
}
