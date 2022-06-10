import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peerbitstest/view/homescreen.dart';

import '../helper/TextPreferences.dart';
import '../helper/toast.dart';
import '../helper/widgets.dart';
import '../model/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  bool passwordVisible = true;
  bool cpasswordVisible = true;
  bool isChecked = false;

  DateTime selectedDate = DateTime.now();
  var outputDate = DateFormat('MM/dd/yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              children: [
                heightBox(120),
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(Icons.person, size: 40),
                ),
                heightBox(30),
                username(),
                heightBox(10),
                InkWell(onTap: () async {
                  final DateTime? picked =await  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                   );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                      outputDate = DateFormat('MM/dd/yyyy').format(selectedDate);
                      print(outputDate);
                    });
                  }
                },child: bodate()),
                heightBox(10),
                email(),
                heightBox(10),
                number(),
                heightBox(10),
                password(),
                heightBox(10),
                confirmpassword(),
                heightBox(10),
                Row(
                  children: [
                    Checkbox(value: isChecked, onChanged:  (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    }),
                    widthBox(15),
                    Text('Agree To'),
                    Text('Terms',style: TextStyle(color: Colors.blue),)
                  ],
                ),
                heightBox(10),
                loginButton(),
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
            hintText: 'Password',
            counterText: "",
            prefixIcon: const Icon(
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

  Widget confirmpassword() {
    return TextField(
        autofocus: false,
        obscureText: cpasswordVisible,
        controller: cpasswordController,
        maxLines: 1,
        maxLength: 20,
        decoration: InputDecoration(
            hintText: 'Confirm Password',
            counterText: "",
            prefixIcon: const Icon(
              Icons.lock,
              size: 18,
            ),
            suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    cpasswordVisible = !cpasswordVisible;
                  });
                },
                child: Icon(
                    cpasswordVisible ? Icons.visibility : Icons.visibility_off)),
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
              if (nameController.text.isEmpty &&
                  passwordController.text.isEmpty && emailController.text.isEmpty && numberController.text.isEmpty) {
                Toast.show("Please Fill Register Details", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              }  else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailController.text)) {
                Toast.show("Please Enter valid Email", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              }else if (numberController.text.isEmpty) {
                Toast.show("Please Enter number", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              }else if (passwordController.text.isEmpty) {
                Toast.show("Please Enter password", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              }else if (passwordController.text.length < 6) {
                Toast.show("password length minimum 6 Char", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              }else if (cpasswordController.text.isEmpty) {
                Toast.show("Please Enter Confirm password", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              }else if (cpasswordController.text.length < 6) {
                Toast.show("confirm password length minimum 6 Char", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              }else if(!isChecked) {
                Toast.show("Please Agree Terms", context,
                    duration: 3,
                    gravity: Toast.bottom,
                    backgroundColor: Colors.black87.withOpacity(0.5),
                    textColor: Colors.white);
              }else {
                if(passwordController.text ==cpasswordController.text){
                  apiCall();
                }else{
                  Toast.show("Password Not Match", context,
                      duration: 3,
                      gravity: Toast.bottom,
                      backgroundColor: Colors.black87.withOpacity(0.5),
                      textColor: Colors.white);
                }
              }
            },
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            color: Colors.lightBlue,
            child: const Text('LogIn',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700))));
  }

  apiCall() async {
    try{
      print('try');
      var response = await http.post(Uri.parse('http://www.mocky.io/v2/5e8d648a310000c23542982e'));
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
        keyboardType: TextInputType.text,
        autofocus: false,
        maxLines: 1,
        maxLength: 20,
        controller: nameController,
        decoration: InputDecoration(
            hintText: 'Full Name',
            counterText: "",
            prefixIcon: Icon(Icons.person, size: 18),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }

  Widget email() {
    return TextField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        maxLines: 1,
        controller: emailController,
        decoration: InputDecoration(
            hintText: 'Email',
            counterText: "",
            prefixIcon: Icon(Icons.person, size: 18),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }

  Widget number() {
    return TextField(
        keyboardType: TextInputType.number,
        autofocus: false,
        maxLines: 1,
        maxLength: 10,
        controller: numberController,
        decoration: InputDecoration(
            hintText: 'Phone Number',
            counterText: "",
            prefixIcon: Icon(Icons.phone, size: 18),
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));
  }

  Widget bodate() {
    return Container(
      padding: EdgeInsets.only(left: 15, top: 5),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.blue, width: 2)),
      child: Row(children: [
        Icon(Icons.calendar_today,size: 18),
        widthBox(15),
        Text(outputDate.toString()),
      ]),
    );
  }
}
