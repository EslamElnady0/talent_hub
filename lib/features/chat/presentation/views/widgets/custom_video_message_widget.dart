import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
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
  bool isLoading = false;
  late CachedVideoPlayerController videoPlayerController;
  @override
  void initState() {
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..addListener(() {})
      ..initialize().then((value) {
        videoPlayerController.setVolume(1);
        setState(() {
          isLoading = false;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
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
                ? const Center(child: CircularProgressIndicator())
                : CachedVideoPlayer(videoPlayerController),
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
                ))
          ],
        ),
      ),
    );
  }
}
