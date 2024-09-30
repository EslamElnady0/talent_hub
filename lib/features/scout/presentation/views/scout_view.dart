import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/widgets/custom_circular_loading_indicator.dart';
import 'package:talent_hub/core/widgets/custom_error_widget.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/add_post_section.dart';
import 'package:talent_hub/features/scout/presentation/manger/scout_cubit/scout_cubit.dart';
import 'package:talent_hub/features/scout/presentation/manger/scout_cubit/scout_states.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_scout_app_bar.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_scout_drawer.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/bloc_builder_post.dart';

import '../manger/post_cubit/post_cubit.dart';

class ScoutView extends StatelessWidget {
  const ScoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ScoutCubit()..getScout()),
        BlocProvider(create: (context) => PostCubit()..getPosts()),
      ],
      child: Builder(builder: (context) {
        return BlocBuilder<ScoutCubit, ScoutStates>(
          builder: (context, state) {
            if (state is SuccessScoutState) {
              return Scaffold(
                drawer: CustomScoutDrawer(userModel: state.userModel),
                appBar: customScoutAppBar(context, state.userModel),
                body: BlocBuilderPost(userModel: state.userModel),
                floatingActionButton: state.userModel.role == "player"
                    ? addPostSection(context, state.userModel)
                    : null,
                floatingActionButtonLocation: state.userModel.role == "player"
                    ? FloatingActionButtonLocation.centerDocked
                    : null,
              );
            } else if (state is FailureScoutState) {
              return CustomErrorWidget(errorMassage: state.error);
            } else {
              return const CustomCircularLoadingIndicator();
            }
          },
        );
      }),
    );
  }
}
