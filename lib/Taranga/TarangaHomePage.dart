import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/BusDetails/Bd.dart';
import 'package:userapp/BusDetails/BusDetailsBody.dart';
import 'package:userapp/BusDetails/Location_view_templete.dart';
import 'package:userapp/SecondaryHomePage/SecondaryBody.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:userapp/Taranga/TarangaAppBar.dart';
import 'package:userapp/Taranga/TarangaBusBody.dart';
import 'package:userapp/Taranga/TarangaFloatingButton.dart';

import '../constants.dart';
import 'package:geolocator/geolocator.dart';

class TarangaHomePage extends StatefulWidget {

  static String appbar_text = Hotel.hotelList[Hotel.selectedHotel].name;

  @override
  State<TarangaHomePage> createState() => _TarangaHomePageState();
}


class _TarangaHomePageState extends State<TarangaHomePage> {

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;





  showDialogBox() => showCupertinoDialog<String>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('No Connection'),
      content: const Text('Please check your internet connectivity'),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            Navigator.pop(context, 'Cancel');
            setState(() => isAlertSet = false);
            isDeviceConnected =
            await InternetConnectionChecker().hasConnection;
            if (!isDeviceConnected && isAlertSet == false) {
              showDialogBox();
              setState(() => isAlertSet = true);
            }
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );


  @override
  void initState() {
    // TODO: implement initState
    getConnectivity();
   // shareflagset();
    super.initState();
  }
  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );



  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
           TarangaHomePage.appbar_text,// Hotel.hotelList[Hotel.selectedHotel].name,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.black,
        ),

        body: TarangaBusBody(),

        floatingActionButton: AllStaticVariables.gps_share_flag==1?
        TarangaFloatingButton() :
        null,
      ),
    );
  }
}
