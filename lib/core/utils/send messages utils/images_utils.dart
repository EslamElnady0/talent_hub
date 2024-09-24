import 'package:image_picker/image_picker.dart';

Future<String?> pickImageFromGallery() async {
  ImagePicker imagePicker = ImagePicker();
  var file = await imagePicker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    return file.path;
  }
  return null;
}

Future<String?> pickImageFromCamera() async {
  ImagePicker imagePicker = ImagePicker();
  var file = await imagePicker.pickImage(source: ImageSource.camera);
  if (file != null) {
    return file.path;
  }
  return null;
}
