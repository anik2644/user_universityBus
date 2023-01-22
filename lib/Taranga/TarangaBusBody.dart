import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/ParticularDetails/TarangaBusBody/ImageSlider.dart';
import 'package:userapp/ParticularDetails/TarangaBusBody/NoticeScreen.dart';
import 'package:userapp/ParticularDetails/TarangaBusBody/TitleScreen.dart';
import 'package:userapp/ParticularDetails/TarangaBusBody/UpDownBuilder.dart';
import '../ParticularDetails/TarangaBusBody/ButtonSection.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class TarangaBusBody extends StatefulWidget {
  static String busName = "kn";
  static String sch = "8.00";
  static String upDown = "up";
  static List<String> locShare = <String>['2', '1', '1', '1', '1', '0', '1', '1', '1'];

  static String Notice = "No Notice So Far";

  TitleScreen tItlescreen= new TitleScreen();
  NoticeScreen nOticescreen = NoticeScreen();
  ImageSlider iMageslider = ImageSlider();
  ButtonSection bUttonSection = ButtonSection();
  UpDownBuilder uPdownbuilder = UpDownBuilder();

  @override
  State<TarangaBusBody> createState() => _TarangaBusBodyState();
}

class _TarangaBusBodyState extends State<TarangaBusBody> {
  int submitFlag = 0;

  List<String> Uptrips = <String>['0.0', '7.02', '8.0', '7.72', '60.0', '74.02'];
  List<String> Downtrips = <String>['0.0', '85.02', '7.02', '8.0', '7.72', '60.0', '74.02'];

  String notic = "No notice so far";

  var selectedBusId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotice();
    load_data();
  }
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1.3,
        child: Column(
          children: [

            widget.iMageslider,
            widget.tItlescreen,
            const SizedBox(
              width: double.infinity,
              height: 5,
            ),
            widget.bUttonSection,
            widget.nOticescreen,
            widget.uPdownbuilder,
          ],
        ),
      ),
    );
  }



  Future<void> _getNotice() async {
    CollectionReference schedule =
    FirebaseFirestore.instance.collection('schedule');

    await schedule
        .where('name', isEqualTo: {
      'busName': Bus.busList[Bus.selectedBus].name,
      // currentUserId.toString(): null
    })
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        //  rreaddata();
        selectedBusId = querySnapshot.docs.single.id;
        print(selectedBusId);
        //print("dound man");
      } else {}
    });

    await FirebaseFirestore.instance
        .collection("schedule")
        .doc(selectedBusId)
        .snapshots()
        .listen((userData) {
      notic = userData.data()!['notice'];
      // setState(() {
      //   myId = userData.data()['uid'];
      //   myUsername = userData.data()['name'];
      //   myUrlAvatar = userData.data()['avatarurl'];
      //
      // });
    });

    // var docSnapshot= await FirebaseFirestore.instance.collection("schedule").doc(selectedBusId).get();
    // if (docSnapshot.exists) {
    //   docSnapshot.data([notice]);
    //   docSnapshot.data()?.forEach((key, value) {
    //
    //     print(value);
    //   });

    // //print(Uptrips);
    // setState(() {
    //   //  llong= position.longitude.toDouble();
    //   //  llat =position.latitude.toDouble();
    //
    // });
  }

  Future<void> load_data() async {
    // print(Hotel.hotelList[Hotel.selectedHotel].name);
    Uptrips.clear();
    Downtrips.clear();
    TarangaBusBody.locShare.clear();

    CollectionReference Loc = FirebaseFirestore.instance.collection('schedule');

    await Loc.where('name', isEqualTo: {
      'busName': Bus.busList[Bus.selectedBus].name,
      // BusDetailsBody.sc: null,
    }).limit(1).get().then(
          (QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          AllStaticVariables.chatDocId = querySnapshot.docs.single.id;
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

    var docSnapshot = await FirebaseFirestore.instance
        .collection("schedule")
        .doc(AllStaticVariables.chatDocId)
        .get();
    if (docSnapshot.exists) {
      List.from(docSnapshot.get('up')).forEach((element) {
        String data = element;
        Uptrips.add(data);
      });
      List.from(docSnapshot.get('down')).forEach((element) {
        String data = element;
        Downtrips.add(data);
      });
      List.from(docSnapshot.get('locShare')).forEach((element) {
        String data = element;
        TarangaBusBody.locShare.add(data);
      });
      setState(() {});
    }
  }


}
