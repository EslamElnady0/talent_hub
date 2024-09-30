import 'package:file_picker/file_picker.dart';

Future<String?> pickFileHelper() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    return result.files.single.path!;
  }
  return null;
}
