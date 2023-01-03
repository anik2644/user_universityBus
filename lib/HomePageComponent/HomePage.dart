import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/HomePageComponent/Drawer.dart';
import 'package:userapp/HomePageComponent/HomePageBody.dart';
import 'package:userapp/Location_view_templete.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("App Bar Text")),
      ),
      body: HomePageBody(),
      drawer: Mydrawer(),

    );
  }
}
