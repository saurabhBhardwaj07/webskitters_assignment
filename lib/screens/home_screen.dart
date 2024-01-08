import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:webskitters_assignment/components/app_basic_layout.dart';
import 'package:webskitters_assignment/data/controller/home_screen_controller.dart';
import 'package:webskitters_assignment/data/repository/unisplsh_repo_impl.dart';
import 'package:webskitters_assignment/screens/photos_details_screen.dart';
import 'package:webskitters_assignment/utils/app_colors.dart';
import 'package:webskitters_assignment/utils/app_textsyle.dart';
import 'package:webskitters_assignment/utils/size_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController _controller =
      HomeScreenController(UniSplashRepoImpl());

  @override
  void initState() {
    _controller.fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBasicLayout(
      screenHeading: "HomeScreen",
      child: Center(
        child: ValueListenableBuilder<bool>(
          valueListenable: _controller.isLoading,
          builder: (context, isLoading, child) {
            return isLoading
                ? const CircularProgressIndicator.adaptive()
                : ListView.builder(
                    itemCount: _controller.photos.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    itemBuilder: (context, index) {
                      var element = _controller.photos[index];
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.fade,
                                child: PhotosDetailsScreen(
                                  item: element,
                                ))),
                        child: Card(
                            elevation: 2.0,
                            surfaceTintColor: AppColors.prusianBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            margin: EdgeInsets.only(bottom: 10.0.h),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Hero(
                                    tag: "image_${element.id}",
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: CachedNetworkImage(
                                        imageUrl: element.urls?.regular ?? "",
                                        fit: BoxFit.fill,
                                        height: 200.v,
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  if (element.description != null)
                                    SizedBox(
                                      height: 10.v,
                                    ),
                                  if (element.description != null)
                                    Text(
                                      element.description ?? "",
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.medium500(),
                                    )
                                ],
                              ),
                            )),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
