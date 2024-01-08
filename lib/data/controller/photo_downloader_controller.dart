// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:webskitters_assignment/data/manager/photo_donwload_manager_impl.dart';

class PhotoDownloaderController {
  final PhotoDownloadManagerImpl manager;
  final BuildContext context;
  PhotoDownloaderController({
    required this.manager,
    required this.context,
  });

  ValueNotifier<bool> downloadingStart = ValueNotifier(false);

  Future<void> downloadPhotos(String url) async {
    try {
      final baseStorage = await getExternalStorageDirectory();
      downloadingStart.value = true;
      await manager.downloadPhoto(baseStorage!.path, url);
    } catch (e) {
      print('Exception: $e');
    } finally {
      downloadingStart.value = false;
    }
  }
}
