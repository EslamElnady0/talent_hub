import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class TalentHubApp extends StatelessWidget {
  const TalentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Talent Hub',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.scout,
        theme: ThemeData(
          fontFamily: 'Outfit',
          focusColor: AppColors.black,
          scaffoldBackgroundColor: AppColors.white,
        ),
      ),
    );
  }
}
