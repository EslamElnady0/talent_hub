import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:video_cached_player/video_cached_player.dart';

class CustomVideoMessageWidget extends StatefulWidget {
  final String videoUrl;
  const CustomVideoMessageWidget({super.key, required this.videoUrl});

  @override
  State<CustomVideoMessageWidget> createState() =>
      _CustomVideoMessageWidgetState();
}

class _CustomVideoMessageWidgetState extends State<CustomVideoMessageWidget> {
  bool isPlaying = false;
  bool isLoading = true; // Default to loading
  late CachedVideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    // Initialize the video player
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        if (videoPlayerController.value.hasError) {
          // Handle video load error
          print("Video Error: ${videoPlayerController.value.errorDescription}");
          setState(() {
            isLoading = false;
          });
        }
      })
      ..initialize().then((_) {
        // Video initialized successfully
        setState(() {
          isLoading = false;
        });
      }).catchError((error) {
        // Handle initialization error
        print("Video initialization error: $error");
        setState(() {
          isLoading = false;
        });
      });
  }

  @override
  void dispose() {
    // Dispose the video player properly
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * 0.7,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.white,
                  ))
                : CachedVideoPlayer(videoPlayerController),
            if (!isLoading)
              IconButton(
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                    if (isPlaying) {
                      videoPlayerController.play();
                    } else {
                      videoPlayerController.pause();
                    }
                  });
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 30.r,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
