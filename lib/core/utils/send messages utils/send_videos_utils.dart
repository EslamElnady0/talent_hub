import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<Uint8List?> pickVideoFromGallery(BuildContext context) async {
  ImagePicker imagePicker = ImagePicker();
  var file = await imagePicker.pickVideo(source: ImageSource.gallery);
  if (file != null) {
    if (context.mounted) {
      context.read<SendFileCubit>().filePath = file.path;
      log("video path ${context.read<SendFileCubit>().filePath = file.path}");
      return await VideoThumbnail.thumbnailData(
        video: context.read<SendFileCubit>().filePath = file.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 512,
        quality: 100,
      );
    }
  }
  return null;
}
