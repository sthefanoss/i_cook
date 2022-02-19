import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed('/recipe-selector');
    });
    super.initState();
  }

  void loadUserData() async {}

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.red);
  }
}
