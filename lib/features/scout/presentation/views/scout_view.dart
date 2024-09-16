import 'package:flutter/material.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_scout_app_bar.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_scout_drawer.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/scout_view_body.dart';

class ScoutView extends StatefulWidget {
  const ScoutView({super.key});

  @override
  State<ScoutView> createState() => _ScoutViewState();
}

class _ScoutViewState extends State<ScoutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomScoutDrawer(),
      appBar: customScoutAppBar(context),
      body: const ScoutViewBody(),
    );
  }
}
