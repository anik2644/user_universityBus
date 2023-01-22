import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/HomePageComponent/HomePage.dart';
import 'package:userapp/Taranga/TarangaAppBar.dart';
import 'package:userapp/Taranga/TarangaBusBody.dart';
import 'package:userapp/Taranga/TarangaFloatingButton.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import '../constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:permission_handler/permission_handler.dart';

import 'InternetConnectionCHecker.dart';

class TarangaHomePage extends StatefulWidget {
  static String appbar_text = Bus.busList[Bus.selectedBus].name;

  ConnectionChecker bOdy = ConnectionChecker(new TarangaBusBody());

  @override
  State<TarangaHomePage> createState() => _TarangaHomePageState();
}

class _TarangaHomePageState extends State<TarangaHomePage> {


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget)),
        child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: TarangaAppbar(),
        ),
        body:widget.bOdy,
        floatingActionButton: AllStaticVariables.gps_share_flag == 1 ? TarangaFloatingButton() :null,
      ),
    );
  }

}
