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

  static const LatLng destination = LatLng(23.725720007917214, 90.4027387200519);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double llat=24.0,llong=85.36;

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
              24.0, 85.36
            ),
            zoom: 2),
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
          Marker(markerId: const MarkerId("currentLocation"),position: LatLng(llat.toDouble(), llong.toDouble()),),
         // const Marker(markerId: MarkerId("destination"),position: MyApp.destination),
          // const Marker(markerId: MarkerId("my"),position: my),
          //

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //
          // await FirebaseFirestore.instance.collection("test").get().then((value) => {
          //   value.docs.forEach((result)
          //   {
          //     print(result.data());
          //     GeoPoint position = result.get('anik');
          //     print(position.longitude.toString());
          //
          //
          //     setState(() {
          //       llong= position.longitude.toDouble();
          //       llat =position.latitude.toDouble();
          //
          //     });
          //   }
          //   )
          // }
          // );


          var docSnapshot= await FirebaseFirestore.instance.collection("test").doc("location").get();
          if (docSnapshot.exists) {

                print(docSnapshot.data());
                GeoPoint position = docSnapshot.get('currentLocation');
                print(position.longitude.toString());


                setState(() {
                  llong= position.longitude.toDouble();
                  llat =position.latitude.toDouble();
 
                });

          }




        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
