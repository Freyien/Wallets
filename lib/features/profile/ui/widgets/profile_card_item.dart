import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:montebit/core/ui/widgets/core_widgets.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';

class ProfileCardItem extends StatelessWidget {
  const ProfileCardItem({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xffFBFAF2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffC5C8B9)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 35,
              child: CachedNetworkImage(
                imageUrl: profile.imageUrl,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            VerticalSpace.small(),
            Text(
              profile.fullName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            VerticalSpace.small(),
            Text(profile.email),
          ],
        ),
      ),
    );
  }
}
