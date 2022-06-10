import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peerbitstest/helper/TextPreferences.dart';
import 'package:peerbitstest/helper/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:peerbitstest/model/productmodel.dart';
import '../helper/toast.dart';
import 'loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String email = "";
  String image = "";

  List isExpanded = [];

  List<ProductList> productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = TextPreferences.getEmail();
    image = TextPreferences.getImage();
    getData();
  }

  getData() async {
    try{
      print('try');
      var response = await http.post(Uri.parse('http://www.mocky.io/v2/5e8d63013100007a54429824'));
      var result = jsonDecode(response.body);

      print('result[data][productList] : ${result['data']['productList']}');
      var product = result['data']['productList'] as List;

      setState(() {
        productList = product != null
            ? product.map((i) => ProductList.fromJson(i)).toList()
            : [];
      });

      print('product : ${productList[0].productName}');

      for(int i=0;i<productList.length;i++){
        isExpanded.add(false);
      }

    }catch(e){
      print(e);
      Toast.show("Unable to connect", context,
          duration: 3,
          gravity: Toast.bottom,
          backgroundColor: Colors.black87.withOpacity(0.5),
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          GestureDetector(
            onTap: () async {
              TextPreferences.clearAllString();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: productList.length != 0 ?
          ListView.separated(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: productList.length,itemBuilder: (context,index){
            return Material(
                color: Color(0xFFFEFEFE).withOpacity(0.6),
            elevation: 10,
            borderRadius: BorderRadius.circular(12),
            shadowColor: Colors.white60,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productList[index].productName!,style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800
                  ),),
                  heightBox(10),
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(productList[index].productImage!),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(isExpanded[index] ? '${productList[index].description}' :'${productList[index].description!.substring(0,80)}...'),
                  InkWell(
                      onTap: (){
                        isExpanded[index] = !isExpanded[index];
                        setState(() {
                        });
                  },child: Text(isExpanded[index] ? 'Less' :'More',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),))
                ],
              ),
            ));
          },separatorBuilder:  (context, index) {
            return heightBox(10);
          },)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
