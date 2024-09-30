import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../manger/player_cubit.dart';
import '../../manger/player_state.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerCubit, PlayerState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        var userModel = PlayerCubit.get(context).user;
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  radius: 80,
                  child: CircleAvatar(
                    radius: 78,
                    backgroundImage: userModel.imageUrl == null
                        ? AssetImage(AppAssets.player)
                        : CachedNetworkImageProvider(userModel.imageUrl!),
                  ),
                ),
                CircleAvatar(
                  radius: 19,
                  backgroundColor: AppColors.white,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: AppColors.primaryColor,
                      size: 19,
                    ),
                    onPressed: () {
                      PlayerCubit.get(context)
                          .selectUploadAndSaveImage(userModel.id);
                    },
                  ),
                ),
              ],
            ),
            vGap(15),
            Text(
              userModel.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(userModel.email, style: const TextStyle(fontSize: 20)),
          ],
        );
      },
    );
  }
}
