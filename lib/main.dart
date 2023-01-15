import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:userapp/Taranga/TarangaHomePage.dart';
import 'package:userapp/SecondaryHomePage/SecondaryBody.dart';
import 'HomePageComponent/HomePage.dart';

Future<void> main() async {

  Hotel.selectedHotel= 3;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}



class MyApp extends StatelessWidget {

  static const LatLng destination = LatLng(23.725720007917214, 90.4027387200519);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TarangaHomePage(),
      //Homepage(),
    );
  }
}
