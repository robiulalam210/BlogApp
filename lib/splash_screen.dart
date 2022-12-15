import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myblog_app/Utlis/splash_services.dart';
import 'package:myblog_app/view/adminhome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashServices().Login(context);
   // Timer(Duration(seconds: 5),()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text("Blog App",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),),
    );
  }
}
