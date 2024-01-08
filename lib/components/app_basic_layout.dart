import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webskitters_assignment/utils/app_colors.dart';
import 'package:webskitters_assignment/utils/app_textsyle.dart';
import 'package:webskitters_assignment/utils/size_utils.dart';

class AppBasicLayout extends StatefulWidget {
  final bool hasParentPadding;
  final Widget child;
  final String? screenHeading;
  final bool hideSideDrawer;
  final bool showAppBar;
  final bool backIcon;
  final Widget? bottomNavigationBar;
  const AppBasicLayout({
    super.key,
    this.hasParentPadding = true,
    this.showAppBar = true,
    this.hideSideDrawer = false,
    this.backIcon = false,
    this.bottomNavigationBar,
    required this.child,
    this.screenHeading,
  });

  @override
  State<AppBasicLayout> createState() => _AppBasicLayoutState();
}

class _AppBasicLayoutState extends State<AppBasicLayout> {
  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        extendBody: true,
        appBar: !widget.showAppBar
            ? null
            : AppBar(
                leading: !widget.backIcon
                    ? null
                    : Padding(
                        padding: EdgeInsets.only(left: 20.h),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor: AppColors.prusianBlue,
                    statusBarIconBrightness: Brightness.dark),
                centerTitle: true,
                backgroundColor: AppColors.prusianBlue,
                elevation: 0.0,
                title: Text(
                  widget.screenHeading ?? "",
                  style: AppTextStyle.headingTextStyle
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                iconTheme: const IconThemeData(color: Colors.black, size: 30),
              ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
                statusBarColor: AppColors.prusianBlue,
                statusBarIconBrightness: Brightness.dark),
            child: Container(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              padding: widget.hasParentPadding
                  ? EdgeInsets.symmetric(horizontal: 24.h)
                  : null,
              child: SafeArea(child: widget.child),
            )));
  }
}
