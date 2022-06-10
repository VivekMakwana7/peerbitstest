import 'package:flutter/material.dart';
import 'package:peerbitstest/view/loginscreen.dart';
import 'package:peerbitstest/view/splash_screen.dart';

import 'helper/TextPreferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await TextPreferences.init();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}