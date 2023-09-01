import 'dart:async';
import 'package:adminapplication/screns/homeScreen.dart';
import 'package:flutter/material.dart';

import '../helper/app_nav.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),(){
      pushAndRemove(context: context, screen: HomePage());
    }
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(

        child: const Text("Admin App",style: TextStyle(color: Colors.white,fontSize: 20),),
      ),
    );
  }
}