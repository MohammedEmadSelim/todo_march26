import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    },);

    super
        .
    initState
      (
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Image.asset("assets/412392476_11600533 1.png"),),
    );
  }
}
