import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myblog_app/view/home.dart';
import 'package:myblog_app/view/signup_login/login.dart';
class SplashServices {
  void Login(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer.periodic(Duration(seconds: 5), (timer) {
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>SingIn()));

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      });
    } else {
      Timer.periodic(Duration(seconds: 5), (timer) {
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>SingIn()));

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      });
    }
  }
}
