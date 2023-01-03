import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/SecondaryHomePage/SecondaryHomePage.dart';

import '../BusDetails/Location_view_templete.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({Key? key}) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /*Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              color: Colors.red,
            ),*/
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>SecondaryHomepage()));
              setState(() {
              });
            },
            child:
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              color: Colors.blueGrey,
              child: Center(child: Text("Press me to enter",style: TextStyle(fontSize: 25),)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            color: Colors.blue,
            child: Center(child: Text("preserved Place",style: TextStyle(fontSize: 25,))),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            color: Colors.blue,
            // child: Center(child: Text("preserved Place",style: TextStyle(fontSize: 25,))),
          ),
        ],
      ),
    );
  }
}
