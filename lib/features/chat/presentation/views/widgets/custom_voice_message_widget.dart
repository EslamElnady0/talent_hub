import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class CustomVoiceMessageWidget extends StatefulWidget {
  final String voiceMessagePath;
  const CustomVoiceMessageWidget({
    super.key,
    required this.voiceMessagePath,
  });

  @override
  State<CustomVoiceMessageWidget> createState() =>
      _CustomVoiceMessageWidgetState();
}

class _CustomVoiceMessageWidgetState extends State<CustomVoiceMessageWidget>
    with AutomaticKeepAliveClientMixin {
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;
  late AudioPlayer audioPlayer;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioPlayer.setSourceUrl(widget.voiceMessagePath);
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = event == PlayerState.playing;
        });

        if (event == PlayerState.completed) {
          setState(() {
            audioPlayer.setSourceUrl(widget.voiceMessagePath);
          });
        }
      }
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      if (mounted) {
        setState(() {
          duration = newDuration;
        });
      }
    });
    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      await audioPlayer.resume();
                    }
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 30.r,
                    color: AppColors.white,
                  )),
              Slider(
                activeColor: AppColors.lightGrey,
                thumbColor: AppColors.lightGrey,
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) {
                  if (mounted) {
                    setState(() {
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    });
                  }
                },
              )
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: 80.w),
              child: isPlaying
                  ? Text(formateTime(position),
                      style: AppTextStyles.font12WhiteW500)
                  : Text(formateTime(duration),
                      style: AppTextStyles.font12WhiteW500),
            ),
          ),
        ],
      ),
    );
  }
}

String formateTime(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return [twoDigitMinutes, twoDigitSeconds].join(":");
}
