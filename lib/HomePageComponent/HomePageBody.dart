import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/StaticPart/FirabaseStaticVariables.dart';
import 'package:userapp/StaticPart/ModelStatic.dart';
import 'package:userapp/Taranga/TarangaHomePage.dart';

import '../StaticPart/BusStaticVariables.dart';
import '../StaticPart/Firebase/FirebaseFetchId.dart';
import '../StaticPart/Firebase/FirebaseReadArray.dart';

class HomePageBody extends StatefulWidget {
  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {

  Future<void> Load() async {

    FirebaseStaticVAriables.isLoading = false;
    FirebaseStaticVAriables.selected_schedule_id = await FirebaseFetchId.getScheduleDocID(BusStaticVariables.busName) as String;

    await FirebaseReadArray.loadNoticeAndTripswithFlag();
    setState(() {
      FirebaseStaticVAriables.isLoading = true;
    });
  }


  Future openDialouge() => showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
              height: 200,
              width: 200,
              child: Center(child: CircularProgressIndicator()))
      ));



  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              if(!FirebaseStaticVAriables.isLoading)
                {
                    openDialouge();
                }
              await ModelStatic.particularBusDataLoad();
              setState(() {
                if(FirebaseStaticVAriables.isLoading)
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TarangaHomePage()));
                  }
              });


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
