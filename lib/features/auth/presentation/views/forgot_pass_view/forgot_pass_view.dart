import 'package:flutter/material.dart';
import 'package:talent_hub/features/auth/presentation/views/forgot_pass_view/widgets/forgot_pass_view_body.dart';

class ForgotPassView extends StatelessWidget {
  const ForgotPassView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ForgotPassViewBody(),
    );
  }
}
