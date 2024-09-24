import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talent_hub/core/helpers/extensions.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routes/app_router.dart';

AppBar profileAbbBar(BuildContext context){
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: const Text(
      'Profile',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
    actions: [
      InkWell(
        onTap: () {
          context.pushNamed(AppRouter.chatInbox);
        },
        child: const FaIcon(
          FontAwesomeIcons.facebookMessenger,
          //color: AppColors.primaryColor,
          //size: 25,
        ),
      ),
      hGap(15),
    ],
  );
}