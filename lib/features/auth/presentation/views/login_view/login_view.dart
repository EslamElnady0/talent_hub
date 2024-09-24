import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/features/auth/data/repo/auth_repo.dart';
import 'package:talent_hub/features/auth/data/repo/user_repo.dart';
import 'package:talent_hub/features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:talent_hub/features/auth/presentation/views/login_view/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginCubit(AuthRepoImpl(UserRepoImpl())),
        child: const LoginViewBody(),
      ),
    );
  }
}
