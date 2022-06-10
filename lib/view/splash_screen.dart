import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helper/TextPreferences.dart';
import 'homescreen.dart';
import 'loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String loggedEmail = "";

  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 2), () async {
      loggedEmail = TextPreferences.getEmail();
      print('loggedEmail : $loggedEmail');
      if (loggedEmail!= "") {
        Navigator.pushReplacement(context, MaterialPageRoute<void>(
          builder: (BuildContext context) => HomeScreen(),
        ));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute<void>(
          builder: (BuildContext context) => LoginScreen(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 200,
                width: 200,
                child: SvgPicture.asset('assets/login.svg'),
              ),
              Text('Welcome to Peerbits Test App',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18),)
            ],
          ),
        ),
      ),
    );
  }
}
