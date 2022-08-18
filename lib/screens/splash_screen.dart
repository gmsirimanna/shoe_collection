import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:products_list/helper/route_helper.dart';

import '../util/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initPrefs());
  }

  initPrefs() async {
    // Check any user still logged in
    Future.delayed(const Duration(seconds: 3), () => _route());
  }

  //Router to Main or Signup
  void _route() {
    Navigator.pushNamedAndRemoveUntil(context, RouteHelper.menu, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Image.asset(
                        Images.splash,
                      )),
                  Text("LET'S GET SOME SHOES", style: GoogleFonts.oswald(fontSize: 20))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
