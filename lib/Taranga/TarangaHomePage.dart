import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/BusDetails/Bd.dart';
import 'package:userapp/BusDetails/BusDetailsBody.dart';
import 'package:userapp/BusDetails/Location_view_templete.dart';
import 'package:userapp/SecondaryHomePage/SecondaryBody.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:userapp/Taranga/TarangaAppBar.dart';
import 'package:userapp/Taranga/TarangaBusBody.dart';
import 'package:userapp/Taranga/TarangaFloatingButton.dart';

import '../constants.dart';

class TarangaHomePage extends StatefulWidget {

  @override
  State<TarangaHomePage> createState() => _TarangaHomePageState();
}

class _TarangaHomePageState extends State<TarangaHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Hotel.hotelList[Hotel.selectedHotel].name,
          style: const TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.black,
      ),

      body: TarangaBusBody(),

      floatingActionButton: AllStaticVariables.gps_share_flag==1?
      TarangaFloatingButton() :
      null,
    );
  }
}
