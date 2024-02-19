import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BubbleUtils {
  static String fileDownloadPath = "";

  static setDownloadFilePath() async {
    if (Platform.isIOS) {
      fileDownloadPath = (await getTemporaryDirectory()).path;
    } else {
      fileDownloadPath = (await getExternalStorageDirectory())!.path;
    }
  }

  static final emailRegex = RegExp(
    r'^(.*?)((mailto:)?[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z][A-Z]+)',
    caseSensitive: false,
  );
  static final urlRegex =
      RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');

  static final phoneNumberRegex =
      RegExp(r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}');

  static Future<String?> downloadFile(String fileUrl, String fileName) async {
    try {
      await setDownloadFilePath();
      if (fileDownloadPath == "") {
        return null;
      }

      String _filePath = fileDownloadPath + "/" + fileName;
      final request = await HttpClient().getUrl(Uri.parse(fileUrl));
      final response = await request.close();
      response.pipe(File(_filePath).openWrite());
      debugPrint("Download path $_filePath");
      return _filePath;
    } catch (e) {
      debugPrint("Something went wrong");
      return null;
    }
  }

  static Future<String?> isFileDownloaded(String fileName) async {
    if (fileDownloadPath.isEmpty) {
      await setDownloadFilePath();
    }

    String _filePath = fileDownloadPath + "/" + fileName;

    if (File(_filePath).existsSync() == true) {
      return _filePath;
    } else {
      return null;
    }
  }
}

