import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:webskitters_assignment/domain/manager/photo_download_manager.dart';

class PhotoDownloadManagerImpl implements PhotoDownloadManager {
  @override
  Future<void> downloadPhoto(String savedDir, String url) async {
    final taskId = await FlutterDownloader.enqueue(
      url: url,
      headers: {
        'Authorization': 'Client-ID 8fZZLAtYG6LkkNbNsa7-_35CESYO-62CM5zQfc_-Nas'
      },
      savedDir: savedDir,
      showNotification: true,
      saveInPublicStorage: true,
      openFileFromNotification: true,
    );
  }
}
