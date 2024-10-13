import 'package:image_picker/image_picker.dart';

Future<String?> pickImageFromGalleryHelper() async {
  ImagePicker imagePicker = ImagePicker();
  var file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return file.path;
  }
  return null;
}

Future<String?> pickImageFromCameraHelper() async {
  ImagePicker imagePicker = ImagePicker();
  var file = await imagePicker.pickImage(source: ImageSource.camera);
  if (file != null) {
    return file.path;
  }
  return null;
}
