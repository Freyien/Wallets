import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({super.key, required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Color(0xffDCE7C7),
      child: CachedNetworkImage(
        imageUrl:
            'https://mkeunlrwbpsaxjgkbcva.supabase.co/storage/v1/object/public/images/avatar.png',
      ),
    );
  }
}
