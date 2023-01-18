import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/HomePageComponent/Drawer.dart';
import 'package:userapp/HomePageComponent/HomePageBody.dart';
import 'package:userapp/BusDetails/Location_view_templete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../SecondaryHomePage/SecondaryBody.dart';
import '../constants.dart'; //

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("App Bar Text")),
      ),
      body: HomePageBody(),
      drawer: Mydrawer(),
      //
       floatingActionButton: FloatingActionButton(
        onPressed: () {

          shareflagset();

        },
      ),

    );
  }
  Future<void> shareflagset() async {
    List<String> locShare=   <String> ['2','0','1','1','1','1','1','1','1'];
    CollectionReference Loc = FirebaseFirestore.instance.collection('schedule');

    await Loc.where('name', isEqualTo: {
      'busName': Hotel.hotelList[Hotel.selectedHotel].name,
      // BusDetailsBody.sc: null,
    }).limit(1).get().then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        AllStaticVariables. chatDocId = querySnapshot.docs.single.id;
        // print(chatDocId);
        //  print("Got it");
      } else {
        // print("Vacant Collection");
        // await Loc.add({
        //   'trip': {
        //     BusDetailsBody.name: null,
        //     BusDetailsBody.sc: null,
        //
        //   },
        //   'currentLocation' : GeoPoint(value.latitude,value.longitude),
        // }).then((value) => {
        //   chatDocId = value});
        // //   print("Arrogant");
      }
    },
    ).catchError((error) {});



    await FirebaseFirestore.instance.collection('schedule').doc(AllStaticVariables.chatDocId)
        .update({
      "locShare": locShare ,
    });
  }

/*
  Future openDialouge() => showDialog(context: context, builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    TextField(
                      decoration:InputDecoration(hintText: "ennterYouNamer",) ,
                    ),
                    SizedBox(height: 10,),
                    TextField(

                      decoration:InputDecoration(hintText: "ennterYouNamer",) ,
                    ),
                    TextButton(onPressed: (){
                      print("already pressed");
                    }, child: Text("Submit")),
                  ],
                ),
              )
          )));
*/

}
