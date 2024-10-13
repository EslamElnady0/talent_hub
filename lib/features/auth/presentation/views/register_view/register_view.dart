import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/features/auth/data/repo/auth_repo.dart';
import 'package:talent_hub/features/auth/presentation/manger/signup_cubit/signup_cubit.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignupCubit(getIt.get<AuthRepo>()),
        child: const RegisterViewBody(),
      ),
    );
  }
}
