import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/HomePageComponent/HomePageDrawer.dart';
import 'package:userapp/HomePageComponent/HomePageBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userapp/HomePageComponent/HomePageFloatingButton.dart';
import 'package:userapp/HomePageComponent/HomrpageAppBar.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import 'package:location/location.dart';
import '../Taranga/InternetConnectionCHecker.dart';
import '../constants.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:flutter_offline/flutter_offline.dart';


class Homepage extends StatefulWidget {

  HomepageAppBar aPpbar = HomepageAppBar();
  HomePageFloatingButtion fLoatingButtton = HomePageFloatingButtion();
  ConnectionChecker bOdy = ConnectionChecker(new HomePageBody());

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
    getConnectivity();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Mydrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: widget.aPpbar,
      ),
      body: widget.bOdy,
      floatingActionButton: widget.fLoatingButtton,

    );
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
