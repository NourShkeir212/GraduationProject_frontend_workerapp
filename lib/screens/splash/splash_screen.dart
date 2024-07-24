import 'dart:async';
import 'package:flutter/material.dart';

import '../../layout/layout_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/var/var.dart';
import '../auth/screens/login/login_screen.dart';
import '../upload_profile_image/upload_profile_image_screen.dart';


class BuildScreen extends StatelessWidget {
  const BuildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (token == "") {
      return const LoginScreen();
    } else {
      if (CacheHelper.getData(key: 'check_profile_image') == null && profileImageUrl=="") {
        return const UploadProfileImageScreen();
      } else {
        return const LayoutScreen();
      }
    }
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => navigateAndFinish(context, const BuildScreen())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Image.asset(
            "assets/images/in_app_images/app_logo.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
