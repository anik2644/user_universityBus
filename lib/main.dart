import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}



class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("anik"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            //target:  current,
             target: LatLng(
              34.4, 90.4
            ),
            zoom: 45),
        polylines:{
          // Polyline(
          //   polylineId: PolylineId("route"),
          //   points: polylineCoordinates,
          //   color: primaryColor,
          //   width:6,
          // )

        } ,
        markers: {
          // const Marker(markerId: MarkerId("source"),position: sourceLocation),
          // Marker(markerId: const MarkerId("current"),position: current),
          // // Marker(markerId: const MarkerId("currentLocation"),position: LatLng(currentlocation!.latitude!.toDouble(), currentlocation!.longitude!.toDouble()),),
          // // const Marker(markerId: MarkerId("destination"),position: destination),
          // const Marker(markerId: MarkerId("my"),position: my),
          //

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          await FirebaseFirestore.instance.collection("test").get().then((value) => {
            value.docs.forEach((result)
            {
              print(result.data());
            }
            )
          }
          );


        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
