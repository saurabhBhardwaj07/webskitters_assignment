import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:webskitters_assignment/components/wave_clipper.dart';
import 'package:webskitters_assignment/screens/home_screen.dart';
import 'package:webskitters_assignment/utils/app_colors.dart';
import 'package:webskitters_assignment/utils/app_textsyle.dart';
import 'package:webskitters_assignment/utils/size_utils.dart';

class AppSplashScreen extends StatefulWidget {
  const AppSplashScreen({super.key});

  @override
  State<AppSplashScreen> createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _fabAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fabAnimation = Tween(begin: 0.5, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut)));
    _controller.forward();

    _controller.addListener(() {
      if (_controller.isCompleted) {
        Timer(const Duration(seconds: 1), () {
          navigateToNextScreen();
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        extendBody: true,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                statusBarColor: Colors.blue[400],
                statusBarIconBrightness: Brightness.light),
            child: SizedBox(
              width: mediaQueryData.size.width,
              height: mediaQueryData.size.height,
              child: SafeArea(
                  child: Column(
                children: [
                  ClipPath(
                    clipper: WaveClipper(),
                    child: Container(
                        height: 160,
                        width: double.infinity,
                        color: Colors.blue[400]),
                  ),
                  const Spacer(),
                  Text.rich(TextSpan(
                      text: "Assignment",
                      style: AppTextStyle.textPageTitleStyle().copyWith(
                          color: AppColors.prusianBlue, fontSize: 25.fSize),
                      children: [
                        TextSpan(
                            text: "   By",
                            style: AppTextStyle.regular400Italic().copyWith(
                              color: Colors.black,
                            ))
                      ])),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _fabAnimation.value,
                        child: Center(
                          child: Image.asset(
                            'assets/images/webskitters_logo.png',
                            height: 280.v,
                            width: 280.h,
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer()
                ],
              )),
            )));
  }
}
