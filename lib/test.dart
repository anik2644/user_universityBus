import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userapp/Test1.dart';
import 'SecondaryHomePage/SecondaryBody.dart';
import 'Taranga/TarangaBusBody.dart';
import 'constants.dart';

class Test extends StatefulWidget {
  static List<String> locShare=   <String> ['0','1','1','1','1','0','1','1','1'];


  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  Test1 tst = new Test1();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("done"),),
      body:tst,
      floatingActionButton: FloatingActionButton(onPressed: (){

      },),
    );
  }
}
