// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:isolate';
import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webskitters_assignment/components/app_basic_layout.dart';
import 'package:webskitters_assignment/data/controller/photo_downloader_controller.dart';
import 'package:webskitters_assignment/data/manager/photo_donwload_manager_impl.dart';
import 'package:webskitters_assignment/domain/model/unisplash_photos_response.dart';
import 'package:webskitters_assignment/utils/app_colors.dart';
import 'package:webskitters_assignment/utils/app_textsyle.dart';
import 'package:webskitters_assignment/utils/size_utils.dart';

class PhotosDetailsScreen extends StatefulWidget {
  final UniSplashPhoto item;
  const PhotosDetailsScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<PhotosDetailsScreen> createState() => _PhotosDetailsScreenState();
}

class _PhotosDetailsScreenState extends State<PhotosDetailsScreen> {
  late final PhotoDownloaderController _controller;

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    _controller = PhotoDownloaderController(
        manager: PhotoDownloadManagerImpl(), context: context);
    super.initState();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (status == DownloadTaskStatus.complete) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Download Completed!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return AppBasicLayout(
        screenHeading: "Details",
        backIcon: true,
        child: Stack(
          children: [
            Positioned.fill(
              child: ListView(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Hero(
                    tag: "image_${widget.item.id}",
                    child: CachedNetworkImage(
                      imageUrl: widget.item.urls?.regular ?? "",
                      fit: BoxFit.fill,
                      height: 250.v,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.thumb_up),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.item.likes.toString(),
                        style: AppTextStyle.headingTextStyle.copyWith(
                            color: AppColors.prusianBlue,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  if (widget.item.description != null)
                    Text(
                      "Description:",
                      style: AppTextStyle.semiBold600()
                          .copyWith(fontSize: 18.fSize),
                    ),
                  if (widget.item.description != null)
                    SizedBox(
                      height: 10.h,
                    ),
                  if (widget.item.description != null)
                    Text(
                      widget.item.description ?? "",
                      textAlign: TextAlign.start,
                      style:
                          AppTextStyle.medium500().copyWith(fontSize: 15.fSize),
                    )
                ],
              ),
            ),
            Positioned(
              bottom: 50.h,
              right: 0,
              child: ValueListenableBuilder<bool>(
                  valueListenable: _controller.downloadingStart,
                  builder: (context, downloading, child) {
                    if (downloading) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Download Started!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      });
                    }
                    return FloatingActionButton(
                      backgroundColor: AppColors.calestialBlue,
                      onPressed: () => downloadClick(),
                      child: const Icon(
                        Icons.download,
                        color: Colors.black,
                      ),
                    );
                  }),
            )
          ],
        ));
  }

  void downloadClick() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      _controller.downloadPhotos(widget.item.urls?.raw ?? "");
    }
  }
}
