import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

AppBar customScoutAppBar(BuildContext context, UserModel userModel) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: true,
    leadingWidth: 65,
    leading: Builder(
      builder: (context) => InkWell(
        onTap: () => Scaffold.of(context).openDrawer(),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: userModel.imageUrl == null
                  ? AssetImage(AppAssets.player)
                  : CachedNetworkImageProvider(
                      userModel.imageUrl ?? "",
                    ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 2.5,
                end: 2.5,
              ),
              child: CircleAvatar(
                radius: 6,
                backgroundColor: AppColors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.only(bottom: 3, end: 3),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: AppColors.primaryColor,
              ),
            )
          ],
        ),
      ),
    ),
    title: const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Talent H'),
        FaIcon(
          FontAwesomeIcons.futbol,
          color: AppColors.primaryColor,
        ),
        Text('B'),
      ],
    ),
    actions: [
      InkWell(
        onTap: () {
          context.pushNamed(AppRouter.chatInbox);
        },
        child: const FaIcon(
          FontAwesomeIcons.facebookMessenger,
          color: AppColors.primaryColor,
        ),
      ),
      hGap(15),
    ],
  );
}
