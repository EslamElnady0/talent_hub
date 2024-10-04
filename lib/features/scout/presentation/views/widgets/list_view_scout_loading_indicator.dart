import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/widgets/custom_fading_widget.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/scout_loading_indicator.dart';
import '../../../../../core/theme/app_colors.dart';

class ListViewHomeLoadingIndicator extends StatelessWidget {
  const ListViewHomeLoadingIndicator({super.key, this.isPostView = false});
  final bool isPostView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: !isPostView ? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomFadingWidget(
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Talent H'),
                FaIcon(
                  FontAwesomeIcons.futbol,
                  color: AppColors.primaryColor,
                ),
                Text('B'),
              ],
            ),
            CustomFadingWidget(
              child: Icon(
                FontAwesomeIcons.facebookMessenger,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ) : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              separatorBuilder: (context, index) => vGap(15),
              itemBuilder: (context, index) =>
                  const CustomLoadingIndicatorHome(),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
