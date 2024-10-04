import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/widgets/custom_error_widget.dart';
import 'package:talent_hub/features/post/presentation/manger/post_cubit/post_cubit.dart';
import 'package:talent_hub/features/scout/presentation/manger/scout_cubit/scout_cubit.dart';
import 'package:talent_hub/features/scout/presentation/manger/scout_cubit/scout_states.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_scout_app_bar.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_scout_drawer.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/bloc_builder_get_posts.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/list_view_scout_loading_indicator.dart';

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
                body: BlocBuilderGetPosts(userModel: state.userModel),
              );
            } else if (state is FailureScoutState) {
              return CustomErrorWidget(errorMassage: state.error);
            } else {
              return const ListViewHomeLoadingIndicator();
            }
          },
        );
      }),
    );
  }
}
