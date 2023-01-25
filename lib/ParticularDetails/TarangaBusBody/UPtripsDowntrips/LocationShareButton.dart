import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:userapp/StaticPart/FirabaseStaticVariables.dart';
import 'package:userapp/StaticPart/Firebase/FirebaseLocationWrite.dart';
import 'package:userapp/StaticPart/Firebase/FirebaseReadArray.dart';
import 'package:userapp/StaticPart/Firebase/FirebaseUpdate.dart';
import 'package:userapp/StaticPart/ModelStatic.dart';

import '../../../StaticPart/BusStaticVariables.dart';
import '../../../Taranga/TarangaHomePage.dart';

class LocationShareButton extends StatefulWidget {

  TextEditingController  _noticeController;
  int index;
  LocationShareButton(this._noticeController,this.index);

  @override
  State<LocationShareButton> createState() => _LocationShareButtonState();
}

class _LocationShareButtonState extends State<LocationShareButton> {

  String latt = "0.00";
  String lonn = "0.00";
  int timeRestartFlag = 1;



  void _updateNotice()
  {

    int flag = 0;
    for (int i = 0;
    i < widget._noticeController.text.length;
    i++) {
      if (widget._noticeController.text.codeUnitAt(i) > 64 &&
          widget._noticeController.text.codeUnitAt(i) < 91 ||
          widget._noticeController.text.codeUnitAt(i) > 96 &&
              widget._noticeController.text.codeUnitAt(i) <
                  123) {
        flag = 1;
        break;
      }
    }
    if (flag == 1) {
      BusStaticVariables.Notice = widget._noticeController.text;
    }

  }
  void _updateLocshareFlag()
  {
    BusStaticVariables.locShare[ ModelStatic.location_share_schedule_index] = "0";
  }



  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {

          ModelStatic.location_share_schedule_index = widget.index;

          FirebaseReadArray.loadLocShreFlag();
          if(BusStaticVariables.locShare[ModelStatic.location_share_schedule_index]==1)
            {


              ModelStatic.start_time = new DateTime.now();

              //for enable location on
              bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
              if (!serviceEnabled) {await Geolocator.getCurrentPosition();}

              _updateNotice();
              _updateLocshareFlag();
              FirebaseUpdate.updateLocshareAndNotice();


              if (ModelStatic.gps_share_flag == 0) {


                loc.Location location = new loc.Location();
                location.enableBackgroundMode(enable: true);
                await location.changeSettings(accuracy: loc.LocationAccuracy.high, distanceFilter: 1);

                ModelStatic.locationSubscription = location.onLocationChanged.listen(
                        (loc.LocationData currentLocation) async {

                      timeRestartFlag = _timeTrack();
                      _timeFlagAction(timeRestartFlag);

                      FirebaseLocationWrite.locationWrite( currentLocation.latitude!, currentLocation.longitude!);
                      _updateAppBar(currentLocation.latitude!.toString(), currentLocation.longitude!.toString());

                    });
                ModelStatic.gps_share_flag = 1;
              }



            }
          else
            {

            }


          _finalAction();
        },
        child: Text("ShareLocation"));
  }

  void _finalAction()
  {


    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TarangaHomePage()));
    //  Navigator.pop(context);
    print("Location Share Done");
  }

  void _updateAppBar(String lat,String lon)
  {
    print(lat);
    print(lon);

    ModelStatic.particularAppbarText = "location: $lat : $lon ";
  }

  int _timeTrack()
  {
    int time_flag = 1;
    DateTime current_time = new DateTime.now();

    if (current_time.year >
        ModelStatic.start_time.year) {
      time_flag = 0;
    } else if (current_time.month >
        ModelStatic.start_time.month) {
      time_flag = 0;
    } else if (current_time.day >
        ModelStatic.start_time.day) {
      time_flag = 0;
    } else if (current_time.hour >
        ModelStatic.start_time.hour + 4) {
      time_flag = 0;
    }

         return time_flag;
  }

  void _timeFlagAction(int timeFlag)
  {
    if (timeFlag == 0) {
      loc.Location.instance
          .enableBackgroundMode(enable: false);
      ModelStatic.locationSubscription
          .cancel();

      ModelStatic.gps_share_flag = 0;
      print("app will restart");
      timeRestartFlag = 1;
    }
  }

}
