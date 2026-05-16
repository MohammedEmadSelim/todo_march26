
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_march26/feature/auth/presentation/ui_screens/login_screen.dart';
import 'package:todo_march26/feature/home/presentation/ui_screens/home_screen.dart';

class SplachScreen extends StatefulWidget {
   SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState(){
    Future.delayed(Duration(seconds: 3)).then((value){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FirebaseAuth.instance.currentUser != null
              ? HomeScreen()
              : LoginScreen(),
          ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Image.asset("assets/images/splach-image.png"),),
    );
  }
}
