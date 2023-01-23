import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:userapp/BusDetails/Location_view_templete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;
import 'package:userapp/StaticPart/BusStaticVariables.dart';
import 'package:userapp/StaticPart/ModelStatic.dart';

import '../../SecondaryHomePage/SecondaryBody.dart';
import '../../Taranga/TarangaBusBody.dart';
import '../../Taranga/TarangaHomePage.dart';
import '../../constants.dart';


class UpDownBuilder extends StatefulWidget {

  @override
  State<UpDownBuilder> createState() => _UpDownBuilderState();
}

class _UpDownBuilderState extends State<UpDownBuilder> {


  List<String> Uptrips = <String>['0.0', '7.02', '8.0', '7.72', '60.0', '74.02'];
  List<String> Downtrips = <String>['0.0', '85.02', '7.02', '8.0', '7.72', '60.0', '74.02'];


  var _noticeController = new TextEditingController();
  var _passCodeController = new TextEditingController();

  Widget ScheduleButton(int index, String time, String ud) {
    return Container(
      // color: Colors.cyanAccent,
      child: Row(
        children: [
          SizedBox(
            width: 6,
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: ud == "down"
                  ? BorderSide(width: 5.0, color: Colors.black26)
                  : BusStaticVariables.locShare[index] == "1"
                  ? BorderSide(width: 5.0, color: Colors.blue)
                  : BusStaticVariables.locShare[index] == "0"
                  ? BorderSide(width: 5.0, color: Colors.green)
                  : BorderSide(width: 5.0, color: Colors.black26),
            ),
            onPressed: ud == "down"
                ? null
                : BusStaticVariables.locShare[index] == "0"
                ? () {
              // print(time);
              // print(ud);
              BusStaticVariables.busName =
              "Taranga"; //Hotel.hotelList[Hotel.selectedHotel].name;
              BusStaticVariables.sch = time;
              BusStaticVariables.upDown = ud;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationView()));

              setState(() {});
            }
                : BusStaticVariables.locShare[index] == "1"
                ? () async {
              getCurrentLocation().then((value) {});

              AllStaticVariables.upDown = ud;
              AllStaticVariables.sch = time;

              if (AllStaticVariables.gps_share_flag == 0) {
                print("Hey I Have Come Here");
                CollectionReference Loc = FirebaseFirestore
                    .instance
                    .collection('Location');
                await Loc.where('trip', isEqualTo: {
                  AllStaticVariables.busName: null,
                  AllStaticVariables.sch: null,
                  AllStaticVariables.upDown: null,
                }).limit(1).get().then(
                      (QuerySnapshot querySnapshot) async {
                    if (querySnapshot.docs.isNotEmpty) {
                      // chatDocId = querySnapshot.docs.single.id;
                      AllStaticVariables.selectedtrip =
                          querySnapshot.docs.single.id;
                      // print("object");
                      print(AllStaticVariables.selectedtrip);
                      print("Got it");
                    } else {
                      print("vacant");
                      await Loc.add({
                        'trip': {
                          AllStaticVariables.busName: null,
                          AllStaticVariables.sch: null,
                          AllStaticVariables.upDown: null,
                        },
                        'currentLocation': GeoPoint(34.4, 90.4),
                      }).then((value) => {
                        //chatDocId = value.id,
                        AllStaticVariables.selectedtrip =
                            value.id,
                        print("my"),
                        print(AllStaticVariables.selectedtrip)
                      });
                      //   print("Arrogant");
                    }
                  },
                ).catchError((error) {});
              }

              openDialouge(index);
            }
                : null,
            child: Text(
              time,
              style: TextStyle(fontSize: 25, color: Colors.blue),
            ),
          ),
          SizedBox(
            width: 6,
          ),
        ],
      ),
    );
  }


  Future openDialouge(int index) => showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
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
                      decoration: InputDecoration(
                        hintText: "Type Any Notice",
                      ),
                      controller: _noticeController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: _passCodeController,
                      decoration: InputDecoration(
                        hintText: "PassCode",
                      ),
                    ),
                    TextButton(
                        onPressed: () async {

                          bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
                          if (!serviceEnabled) {
                            await Geolocator.getCurrentPosition();
                          }

                          int flag = 0;
                          for (int i = 0;
                          i < _noticeController.text.length;
                          i++) {
                            if (_noticeController.text.codeUnitAt(i) > 64 &&
                                _noticeController.text.codeUnitAt(i) < 91 ||
                                _noticeController.text.codeUnitAt(i) > 96 &&
                                    _noticeController.text.codeUnitAt(i) <
                                        123) {
                              flag = 1;
                              break;
                            }
                          }
                          if (flag == 1) {
                            BusStaticVariables.Notice = _noticeController.text;
                          }
                          //Notice set done

                          //  locShare.add("0");
                          //print(locShare.length);
                          BusStaticVariables.locShare[index] = "0";
                          AllStaticVariables.location_share_schedule_index =
                              index;
                          print(AllStaticVariables.chatDocId);
                          await FirebaseFirestore.instance
                              .collection('schedule')
                              .doc(AllStaticVariables.chatDocId)
                              .update({
                            "locShare": BusStaticVariables.locShare,
                            'notice': BusStaticVariables.Notice
                          });

                          //gpsshereflag

                          if (AllStaticVariables.gps_share_flag == 0) {
                            loc.Location location = new loc.Location();
                            location.enableBackgroundMode(enable: true);
                            print(location
                                .getLocation()
                                .then((value) => print(value.longitude)));
                            await location.changeSettings(
                                accuracy: loc.LocationAccuracy.high,
                                distanceFilter: 1);

                            AllStaticVariables.locationSubscription =
                                location.onLocationChanged.listen(
                                        (loc.LocationData currentLocation) async {
                                      if (AllStaticVariables.gps_share_flag == 1) {
                                        // print("with come");
                                        int time_flag = 1;

                                        DateTime current_time = new DateTime.now();

                                        if (current_time.year >
                                            AllStaticVariables.start_time.year) {
                                          time_flag = 0;
                                        } else if (current_time.month >
                                            AllStaticVariables.start_time.month) {
                                          time_flag = 0;
                                        } else if (current_time.day >
                                            AllStaticVariables.start_time.day) {
                                          time_flag = 0;
                                        } else if (current_time.hour >
                                            AllStaticVariables.start_time.hour + 4) {
                                          time_flag = 0;
                                        }

                                        //
                                        // else if(current_time.minute>AllStaticVariables.start_time.minute)
                                        // {
                                        //   time_flag =0;
                                        // }

                                        if (time_flag == 0) {
                                          loc.Location.instance
                                              .enableBackgroundMode(enable: false);
                                          AllStaticVariables.locationSubscription
                                              .cancel();

                                          AllStaticVariables.gps_share_flag = 0;
                                          print("app will restart");
                                        }
                                        print(AllStaticVariables.selectedtrip);

                                        setState(() {});
                                      }

                                      print(AllStaticVariables.selectedtrip);
                                      print(currentLocation.latitude!);
                                      print(currentLocation.longitude!);
                                      await FirebaseFirestore.instance
                                          .collection("Location")
                                          .doc(AllStaticVariables.selectedtrip)
                                          .update({
                                        'currentLocation': GeoPoint(
                                            currentLocation.latitude!,
                                            currentLocation.longitude!)
                                      });

                                      AllStaticVariables.gps_share_flag = 1;
                                      AllStaticVariables.start_time =
                                      new DateTime.now();

                                      // await FirebaseFirestore.instance.collection("test").doc(
                                      //     'justForTesting').set({
                                      //   'currentLocation': GeoPoint(currentLocation.latitude!, currentLocation.longitude!),
                                      // });
                                      //
                                      // print(playCount);
                                      // print("object");
                                      // playCount++;
                                      // past = current;
                                      // current= currentLocation.longitude!;
                                      // print(currentLocation.longitude);
                                      // print("object222");
                                      setState(() {
                                        latt = currentLocation.latitude!.toString();
                                        lonn = currentLocation.longitude!.toString();
                                        ModelStatic.particularAppbarText =
                                        "location: $latt ,,$lonn ";
                                      });
                                    });
                          }


                          setState(() {});
                          AllStaticVariables.gps_share_flag = 1;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TarangaHomePage()));
                          //  Navigator.pop(context);
                          print("already pressed");
                        },
                        child: Text("Submit")),
                  ],
                ),
              ))));


  @override
  void initState() {
    // TODO: implement initState
   // load_data();
    super.initState();
  }

  String latt = "0.00";
  String lonn = "0.00";

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        ListTile(
          title: Text(
            "Up Trips:" //Hotel.hotelList[Hotel.selectedHotel].description
            /*'Hotel Description'*/
            ,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),

        Container(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 25, right: 25, top: 5),
              itemCount: BusStaticVariables.Uptrips.length,
              itemBuilder: (context, index) => ScheduleButton(
                index,
                BusStaticVariables.Uptrips[index],
                "up",
              )),
        ),

        ListTile(
          title: Text(
            "Down Trips:"
            ,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),

        Container(
          height: 100,
          child: ListView.builder(
            //shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: BusStaticVariables.Downtrips.length,
              padding: EdgeInsets.only(right: 25, left: 25, top: 10),
              itemBuilder: (context, index) =>
                  ScheduleButton(index, BusStaticVariables.Downtrips[index], "down")),
        ),
      ],
    );
  }


  Future<void> load_data() async {
    // print(Hotel.hotelList[Hotel.selectedHotel].name);
    Uptrips.clear();
    Downtrips.clear();
    BusStaticVariables.locShare.clear();

    CollectionReference Loc = FirebaseFirestore.instance.collection('schedule');

    await Loc.where('name', isEqualTo: {
      'busName': Bus.busList[Bus.selectedBus].name,
      // BusDetailsBody.sc: null,
    }).limit(1).get().then(
          (QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          AllStaticVariables.chatDocId = querySnapshot.docs.single.id;
        } else {
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
        BusStaticVariables.locShare.add(data);
      });
      setState(() {});
    }
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always) {
        print("always use");
        await Geolocator.getCurrentPosition();
        //return Future.error('Location while in use');
      }

      if (permission == LocationPermission.whileInUse) {
        await Geolocator.openAppSettings();
        await Geolocator.getCurrentPosition();
        print("uing app");
        // return Future.error('Location while in use');
      }

      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        await Geolocator.getCurrentPosition();
        //return Future.error('Location permission denied');
      }
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        await Geolocator.getCurrentPosition();
        //return Future.error('Location permanently denied');
      }
      // return await Geolocator.getCurrentPosition();
      //return Future.error('Location service disabled');
    } else if (serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always) {
        print("always use");
        await Geolocator.getCurrentPosition();
        //return Future.error('Location while in use');
      }

      if (permission == LocationPermission.whileInUse) {
        await Geolocator.openAppSettings();
        await Geolocator.getCurrentPosition();
        print("uing app");
        // return Future.error('Location while in use');
      }

      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        await Geolocator.getCurrentPosition();
        //return Future.error('Location permission denied');
      }
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        await Geolocator.getCurrentPosition();
        //return Future.error('Location permanently denied');
      }
      //return await Geolocator.getCurrentPosition();
      //return Future.error('Location service disabled');
    }
    //   LocationPermission permission = await Geolocator.checkPermission();
    //   if(permission==LocationPermission.denied)
    //   {
    //     permission = await Geolocator.requestPermission();
    //     if(permission== LocationPermission.denied)
    //     {
    //       return Future.error('Location permission denied');
    //     }
    //   }
    //   if(permission== LocationPermission.deniedForever)
    //   {
    //     return Future.error('Location permanently denied');
    //   }
    return await Geolocator.getCurrentPosition();
  }


}
