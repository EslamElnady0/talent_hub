import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:video_player/video_player.dart';
import '../../../../../../core/theme/app_colors.dart';

class VideoPostSection extends StatefulWidget {
  const VideoPostSection({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<VideoPostSection> createState() => _VideoPostSectionState();
}

class _VideoPostSectionState extends State<VideoPostSection> {
  late VideoPlayerController controller;
  bool isPlay = false;
  bool isLoaded = false;
  Future<void> initializeVideoPlayer() async {
    try {
      controller = VideoPlayerController.network(
        widget.postModel.videoUrl,
      );
      await controller.initialize();
      isLoaded = true;
      setState(() {});
    } catch (e) {
      log("Error initializing video player: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
  }

  @override
  void dispose() {
    controller.pause();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          if (controller.value.isPlaying) {
            controller.pause();
            isPlay = false;
          } else {
            controller.play();
            isPlay = true;
          }
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: isLoaded
                ? AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: VideoPlayer(controller))
                : SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: VideoPlayer(controller),
                  ),
          ),
          Icon(
            !isPlay ? Icons.play_arrow : Icons.pause,
            size: 30,
            color: AppColors.white,
          )
        ],
      ),
    );
  }
}
