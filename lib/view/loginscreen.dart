import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peerbitstest/helper/TextPreferences.dart';
import 'package:peerbitstest/helper/toast.dart';
import 'package:peerbitstest/view/register.dart';
import 'package:http/http.dart' as http;
import 'package:peerbitstest/model/usermodel.dart';

import '../helper/widgets.dart';
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                heightBox(150),
                Container(
                  height: 200,
                  width: 200,
                  child: SvgPicture.asset('assets/login.svg'),
                ),
                heightBox(30),
                username(),
                heightBox(10),
                password(),
                heightBox(10),
                loginButton(),
                heightBox(10),
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Don\'t Have an Account?',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget password() {
    return TextField(
        autofocus: false,
        obscureText: passwordVisible,
        controller: passwordController,
        maxLines: 1,
        maxLength: 20,
        decoration: InputDecoration(
            hintText: 'Enter Password',
            counterText: "",
            prefixIcon: Icon(
              Icons.lock,
              size: 18,
            ),
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
                child: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }

  Widget loginButton() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            onPressed: () async {
              if (userController.text.isEmpty &&
                  passwordController.text.isEmpty) {
                Toast.show("Please Fill Login Details", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(userController.text)) {
                Toast.show("Please Enter valid Email", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              } else if (passwordController.text.length < 6) {
                Toast.show("Password can not be less than 6 char", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              } else {
  apiCalling();
              }
            },
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            color: Colors.lightBlue,
            child: const Text('Log In',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700))));
  }

  apiCalling() async {
    print('Function call');
    try{
      print('try');
      var response = await http.post(Uri.parse('http://www.mocky.io/v2/5e415deb2f0000520058348a'));
      var result = jsonDecode(response.body);

      user userData = user.fromJson(result['data']['user']);

      TextPreferences.setEmail(userData.email!);
      TextPreferences.setImage(userData.image!);
      TextPreferences.setName(userData.first_name!);
      print('email : ${userData.email}');

      Navigator.pushReplacement(context, MaterialPageRoute<void>(
        builder: (BuildContext context) => HomeScreen(),
      ));

    }catch(e){
      Toast.show("Unable to connect", context,
          duration: 3,
          gravity: Toast.bottom,
          backgroundColor: Colors.black87.withOpacity(0.5),
          textColor: Colors.white);
    }
  }

  Widget username() {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        maxLines: 1,
        maxLength: 20,
        controller: userController,
        decoration: InputDecoration(
            hintText: 'Enter Email',
            counterText: "",
            prefixIcon: Icon(Icons.person, size: 18),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }
}
