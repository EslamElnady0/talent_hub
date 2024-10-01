// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:talent_hub/core/widgets/custom_circular_loading_indicator.dart';
// import 'package:talent_hub/core/widgets/custom_error_widget.dart';
// import 'package:talent_hub/features/player/presentation/views/widgets/player_view_body.dart';
// import 'package:talent_hub/features/scout/presentation/manger/scout_cubit/scout_cubit.dart';
// import 'package:talent_hub/features/scout/presentation/manger/scout_cubit/scout_states.dart';
// import '../../../scout/presentation/views/widgets/custom_scout_app_bar.dart';
// import '../../../scout/presentation/views/widgets/custom_scout_drawer.dart';

// class PlayerView extends StatelessWidget {
//   const PlayerView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ScoutCubit(),
//       child: Builder(builder: (context) {
//         return BlocBuilder<ScoutCubit, ScoutStates>(
//           builder: (context, state) {
//             if (state is SuccessScoutState) {
//               return Scaffold(
//                 drawer: CustomScoutDrawer(userModel: state.userModel),
//                 appBar: customScoutAppBar(context, state.userModel),
//                 body: const PlayerViewBody(),
//               );
//             } else if (state is FailureScoutState) {
//               return CustomErrorWidget(errorMassage: state.error);
//             } else {
//               return const CustomCircularLoadingIndicator();
//             }
//           },
//         );
//       }),
//     );
//   }
// }
