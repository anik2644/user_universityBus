import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/HomePageComponent/Drawer.dart';
import 'package:userapp/HomePageComponent/HomePageBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import 'package:location/location.dart';
import '../Taranga/InternetConnectionCHecker.dart';
import '../constants.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:flutter_offline/flutter_offline.dart';


class Homepage extends StatefulWidget {

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {


  late per.PermissionStatus _status;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // TODO: implement initState

   // getConnectivity();
    super.initState();
    setState(() {

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("App Bar Text")),
      ),
      body:ConnectionChecker(new HomePageBody()),
      /*
      Builder(
          builder: (BuildContext context) {
            return OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity != ConnectivityResult.none;
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    child,
                    Positioned(
                      left: 0.0,
                      right: 0.0,
                      height: 32.0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        color:
                        connected ?/* Color(0xFF00EE44) */ null : Color(0xFFEE4400),
                        child: connected
                            ?/*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "ONLINE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                           */ null

                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "OFFLINE",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            SizedBox(
                              width: 12.0,
                              height: 12.0,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                                valueColor:
                                AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: HomePageBody(),);}),
      */
      drawer: Mydrawer(),

       floatingActionButton: FloatingActionButton(
        onPressed: () {

          setState(() {

          });
          getConnectivity();
          shareflagset();

          },
         child: Icon(Icons.refresh,color: Colors.white,),
         backgroundColor: Colors.black,
      ),

    );
  }
  Future<void> shareflagset() async {

    AllStaticVariables.gps_share_flag=0;
   // Location.instance.enableBackgroundMode(enable: false);
  //  AllStaticVariables.locationSubscription.cancel();

    List<String> locShare=   <String> ['2','0','1','1','1','1','1','1','1'];
    CollectionReference Loc = FirebaseFirestore.instance.collection('schedule');

    await Loc.where('name', isEqualTo: {
      'busName': Bus.busList[Bus.selectedBus].name,
      // BusDetailsBody.sc: null,
    }).limit(1).get().then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        AllStaticVariables.chatDocId = querySnapshot.docs.single.id;
         //print(AllStaticVariables.chatDocId);
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


   // print("In floatiing action button");

    await FirebaseFirestore.instance.collection('schedule').doc(AllStaticVariables.chatDocId)
        .update({
      "locShare": locShare ,
    });
  }




  getConnectivity() {
    return subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );
  }

  showDialogBox() {
    return showCupertinoDialog<String>(
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
  }



}
