import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:userapp/StaticPart/FirabaseStaticVariables.dart';
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

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () async {

          ModelStatic.location_share_schedule_index = widget.index;
          bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
          if (!serviceEnabled) {
            await Geolocator.getCurrentPosition();
          }

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



          BusStaticVariables.locShare[widget.index] = "0";
          ModelStatic.location_share_schedule_index = widget.index;

          print(FirebaseStaticVAriables.selected_schedule_id);

          await FirebaseFirestore.instance
              .collection('schedule')
              .doc(FirebaseStaticVAriables.selected_schedule_id)
              .update({
            "locShare": BusStaticVariables.locShare,
            'notice': BusStaticVariables.Notice
          });

          //gpsshereflag

          if (ModelStatic.gps_share_flag == 0) {
            loc.Location location = new loc.Location();
            location.enableBackgroundMode(enable: true);
            print(location
                .getLocation()
                .then((value) => print(value.longitude)));
            await location.changeSettings(
                accuracy: loc.LocationAccuracy.high,
                distanceFilter: 1);

            ModelStatic.locationSubscription =
                location.onLocationChanged.listen(
                        (loc.LocationData currentLocation) async {


                      if (ModelStatic.gps_share_flag == 1) {
                        // print("with come");
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



                        if (time_flag == 0) {
                          loc.Location.instance
                              .enableBackgroundMode(enable: false);
                          ModelStatic.locationSubscription
                              .cancel();

                          ModelStatic.gps_share_flag = 0;
                          print("app will restart");
                        }

                      }


                      print(currentLocation.latitude!);
                      print(currentLocation.longitude!);


                      await FirebaseFirestore.instance
                          .collection("Location")
                          .doc(FirebaseStaticVAriables.selected_location_id)
                          .update({
                        'currentLocation': GeoPoint(
                            currentLocation.latitude!,
                            currentLocation.longitude!)
                      });

                      ModelStatic.gps_share_flag = 1;
                      ModelStatic.start_time = new DateTime.now();


                            latt = currentLocation.latitude!.toString();
                            lonn = currentLocation.longitude!.toString();
                            ModelStatic.particularAppbarText = "location: $latt ,,$lonn ";




                    });
          }


          ModelStatic.gps_share_flag = 1;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TarangaHomePage()));
          //  Navigator.pop(context);
          print("already pressed");
        },
        child: Text("ShareLocation"));
  }
}
