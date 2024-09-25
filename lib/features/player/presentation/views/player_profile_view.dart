import 'package:flutter/material.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/player_profile_body.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/profile_app_bar.dart';



class PlayerProfileView extends StatelessWidget {
  const PlayerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAbbBar(context),
      body: const PlayerProfileBody(),
    );
  }
}
