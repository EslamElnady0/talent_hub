import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

void startRecording({
  required AudioRecorder audioRecorder,
}) async {
  try {
    if (await audioRecorder.hasPermission()) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      final String recFilePath = p.join(
          appDocDir.path, '${DateTime.now().millisecondsSinceEpoch}.m4a');
      await audioRecorder.start(const RecordConfig(), path: recFilePath);
    }
  } catch (e) {
    log("error in recording $e");
  }
}

void stopRecording({
  required AudioRecorder audioRecorder,
}) async {
  await audioRecorder.cancel();
}
