import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/Taranga/TarangaHomePage.dart';

class HomePageBody extends StatefulWidget {
  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TarangaHomePage()));
              setState(() {});
            },
            child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: double.infinity,
              color: Colors.blueGrey,
              child: Center(
                  child: Text(
                "Press me to enter",
                style: TextStyle(fontSize: 25),
              )),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: double.infinity,
            color: Colors.blue,
            child: Center(
                child: Text("preserved Place",
                    style: TextStyle(
                      fontSize: 25,
                    ))),
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
