import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:userapp/Taranga/TarangaBusBody.dart';
import '../constants.dart';
import 'TarangaHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TarangaFloatingButton extends StatefulWidget {
  const TarangaFloatingButton({Key? key}) : super(key: key);

  @override
  State<TarangaFloatingButton> createState() => _TarangaFloatingButtonState();
}

class _TarangaFloatingButtonState extends State<TarangaFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton.extended(

      icon: Icon(Icons.backspace_sharp),
      label: Text('Stop Share'),
      backgroundColor: Colors.red,
      onPressed: () async {
        // Geolocator.
        //AllStaticVariables.mapshareflag=0;
        AllStaticVariables.gps_share_flag=0;


        TarangaBusBody.locShare[AllStaticVariables.location_share_schedule_index]="2";
        print(AllStaticVariables.chatDocId);
        await FirebaseFirestore.instance.collection('schedule').doc(AllStaticVariables.chatDocId)
            .update({
          "locShare": TarangaBusBody.locShare
        });


        loc.Location.instance.enableBackgroundMode(enable: false);
        AllStaticVariables.locationSubscription.cancel();
        //  FlutterBackgroundService().sendData({'action': 'stopService'});

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TarangaHomePage() ));
      },

    );
  }
}
