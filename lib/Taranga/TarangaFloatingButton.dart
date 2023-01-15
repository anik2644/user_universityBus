import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'TarangaHomePage.dart';

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
      onPressed: (){
        // Geolocator.
        AllStaticVariables.mapshareflag=0;
        AllStaticVariables.gps_share_flag=0;
        //  FlutterBackgroundService().sendData({'action': 'stopService'});

        Navigator.push(context, MaterialPageRoute(builder: (context) => TarangaHomePage() ));
      },

    );
  }
}
