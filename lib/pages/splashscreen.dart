import 'dart:async';

import 'package:ecom/constants/myimages.dart';
import 'package:ecom/pages/HomeScreen/homeview.dart';
import 'package:ecom/pages/login%20screen/login.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  

  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => SplashscreenState();
}

class SplashscreenState extends State<Splashscreen> {
  static  const  String  ISLOGIN = "LOGGEDIN";

  @override
  void initState() {
    
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var isloggedin = prefs.get(ISLOGIN);
      if (isloggedin != null) {
        if (isloggedin = true) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Homeview()));
        }
        else{
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
        }

        
      }
      else{
        Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Login()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage(Myimages.logoimg),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
