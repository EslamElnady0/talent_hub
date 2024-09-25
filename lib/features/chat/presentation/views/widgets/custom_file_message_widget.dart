import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/DI/dependency_injection.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class CustomFileMessageWidget extends StatefulWidget {
  final String fileUrl;
  const CustomFileMessageWidget({super.key, required this.fileUrl});

  @override
  State<CustomFileMessageWidget> createState() =>
      _CustomFileMessageWidgetState();
}

class _CustomFileMessageWidgetState extends State<CustomFileMessageWidget> {
  Future<bool> isDownloaded(String fileName) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';
    File file = File(filePath);
    return file.existsSync();
  }

  @override
  Widget build(BuildContext context) {
    String fileName = widget.fileUrl.split("%2F").last.split("?").first;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () async {
          try {
            if (await isDownloaded(fileName)) {
              Directory appDocDir = await getApplicationDocumentsDirectory();
              String filePath = '${appDocDir.path}/$fileName';
              log(filePath);
              await Permission.storage.request();
              await Permission.manageExternalStorage.request();
              final result = await OpenFile.open(filePath);
              if (result.type != ResultType.done) {
                // Handle the error here
                log('Error opening file: ${result.message}');
              }
            } else {
              await downloadFile(widget.fileUrl, fileName, () {
                setState(() {});
              });
            }
          } catch (e) {
            log('Error: $e');
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<bool>(
                future: isDownloaded(fileName),
                builder: (builder, snapshot) {
                  if (snapshot.hasData && snapshot.data!) {
                    return Icon(
                      Icons.file_copy,
                      size: 30.r,
                      color: AppColors.white,
                    );
                  } else {
                    return Icon(
                      Icons.download,
                      size: 30.r,
                      color: AppColors.white,
                    );
                  }
                }),
            hGap(15),
            SizedBox(
                width: 150.w,
                child: Text(
                  fileName,
                  style: AppTextStyles.font15WhiteW500,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
      ),
    );
  }
}

Future<void> downloadFile(
    String fileUrl, String fileName, VoidCallback function) async {
  try {
    // Get the reference to the file in Firebase Storage
    Reference storageRef = getIt.get<FirebaseStorage>().refFromURL(fileUrl);

    // Get the directory to save the file
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = '${appDocDir.path}/$fileName';

    // Download the file and write it to the local file
    File downloadToFile = File(filePath);
    await storageRef.writeToFile(downloadToFile);
    log('File downloaded to $filePath');
    log('File size: ${downloadToFile.lengthSync()}');

    function();
  } catch (e) {
    log('Error downloading file: $e');
  }
}
