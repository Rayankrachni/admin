import 'dart:async';
import 'package:adminapplication/helper/app_shared.dart';
import 'package:adminapplication/screns/Login.dart';
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
        const Duration(seconds: 3),() async{
      /*bool? isLogin =  await SharedPreferencesHelper.getBool('login');
      if(isLogin==null || isLogin == false){
        pushAndRemove(context: context, screen: LoginScreen());
      }
      else{

      }*/
      pushAndRemove(context: context, screen:  HomePage());
    }
    );

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff701B45),
      body: Center(

        child: Image.asset("assets/images/fca-logo.jpg")
      ),
    );
  }
}