import 'package:flutter/material.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/player_view_body.dart';

import '../../../scout/presentation/views/widgets/custom_scout_app_bar.dart';
import '../../../scout/presentation/views/widgets/custom_scout_drawer.dart';
class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomScoutDrawer(),
      appBar: customScoutAppBar(context),
      body: const PlayerViewBody(),
    );
  }
}
