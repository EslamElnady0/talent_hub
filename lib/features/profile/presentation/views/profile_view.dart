import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/profile/presentation/manger/profile_cubit.dart';
import 'package:talent_hub/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var userModel = ModalRoute.of(context)!.settings.arguments as UserModel;
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: SafeArea(
        child: Scaffold(
          body: ProfileViewBody(userModel: userModel),
        ),
      ),
    );
  }
}
