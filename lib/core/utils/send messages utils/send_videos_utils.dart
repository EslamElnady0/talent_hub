import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future<Uint8List?> pickVideoFromGallery({required String? videoPath}) async {
  ImagePicker imagePicker = ImagePicker();
  var file = await imagePicker.pickVideo(source: ImageSource.gallery);
  if (file != null) {
    videoPath = file.path;
    return await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 512,
      quality: 100,
    );
  }
  return null;
}
