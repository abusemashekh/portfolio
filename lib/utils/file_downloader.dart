import 'dart:html' as html;
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_portfolio/utils/custom_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileDownloader {
  static Future<String?> downloadFile({
    required String url,
    required String fileName,
    required String savePath,
    required String successMessage,
    required String errorMessage,
  }) async {
    try {
      if (kIsWeb) {
        html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..click();
        CustomSnackBar.show(
          title: 'Success',
          message: successMessage,
          isError: false,
        );
        return url;
      }
      if (!kIsWeb) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          CustomSnackBar.show(
            title: 'Permission Required',
            message: 'Storage permission is required to download the file',
            isError: true,
          );
          return null;
        }
      }

      io.Directory? directory;
      if (io.Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else if (io.Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not get the download directory');
      }

      final saveDir = io.Directory('${directory.path}/$savePath');
      if (!await saveDir.exists()) {
        await saveDir.create(recursive: true);
      }

      final fullPath = '${saveDir.path}/$fileName';
      final dio = Dio();

      await dio.download(
        url,
        fullPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            CustomSnackBar.show(
              title: 'Downloading...',
              message: '$progress% completed',
              isError: false,
            );
          }
        },
      );

      CustomSnackBar.show(
        title: 'Success',
        message: successMessage,
        isError: false,
      );

      return fullPath;
    } catch (e) {
      if (kDebugMode) {
        print('Download error: $e');
      }
      CustomSnackBar.show(
        title: 'Error',
        message: errorMessage,
        isError: true,
      );
      return null;
    }
  }
}
