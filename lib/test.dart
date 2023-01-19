import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'SecondaryHomePage/SecondaryBody.dart';
import 'Taranga/TarangaBusBody.dart';
import 'constants.dart';

class Test extends StatefulWidget {
  static List<String> locShare=   <String> ['0','1','1','1','1','0','1','1','1'];


  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  List<String> Uptrips=   <String> ['0.0','7.02','8.0','7.72','60.0','74.02'];
  List<String> Downtrips=   <String> ['0.0','85.02','7.02','8.0','7.72','60.0','74.02'];

  late String data;
  Map<String,String> mp={
    "name" : "anik",
    "roll" : "44",
  };

  Future<void> load_data() async {
    // print(Hotel.hotelList[Hotel.selectedHotel].name);
    Uptrips.clear();
    Downtrips.clear();
    TarangaBusBody.locShare.clear();

    CollectionReference Loc = FirebaseFirestore.instance.collection('schedule');

    await Loc.where('name', isEqualTo: {
      'busName': Bus.busList[Bus.selectedBus].name,
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


    var docSnapshot= await FirebaseFirestore.instance.collection("schedule").doc(AllStaticVariables.chatDocId).get();
    if (docSnapshot.exists) {

      List.from(docSnapshot.get('forTest')).forEach((element){
        data=element['sch'].toString();
      //  String data = element;
       // print(element['sch'].toString());
      //  Uptrips.add(data);
      });

      await FirebaseFirestore.instance.collection('schedule').doc(AllStaticVariables.chatDocId)
          .update({
        "forTest": {
          mp,
        }
        // {
        //   // 'sch' : '12.50',
        //   // 'flag' : '1',
        // },
       // 'notice' : notic
      });



      // List.from(docSnapshot.get('up')).forEach((element){
      //   String data = element;
      //   Uptrips.add(data);
      // });
      // List.from(docSnapshot.get('down')).forEach((element){
      //   String data = element;
      //   Downtrips.add(data);
      // });
      // List.from(docSnapshot.get('locShare')).forEach((element){
      //   String data = element;
      //   TarangaBusBody.locShare.add(data);
      // });
      setState(() {

        print(data);
        // for(int i=0;i<Uptrips.length;i++)
        // {
        //   print("uptrips:");
        //   print(Uptrips[i]);
        // }
        //
        // for(int i=0;i<Downtrips.length;i++)
        // {
        //   print("Downtrips:");
        //   print(Downtrips[i]);
        // }
        // for(int i=0;i<Test.locShare.length;i++)
        // {
        //   print("Locshare:");
        //   print(Test.locShare[i]);
        // }



      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("done"),),
      body:Container(),
      floatingActionButton: FloatingActionButton(onPressed: (){

        load_data();


      },),
    );
  }
}
