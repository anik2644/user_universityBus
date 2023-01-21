import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:userapp/HomePageComponent/HomePage.dart';
import 'package:userapp/Taranga/TarangaBusBody.dart';
import 'package:userapp/Taranga/TarangaFloatingButton.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import '../constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:permission_handler/permission_handler.dart';

class TarangaHomePage extends StatefulWidget {
  static String appbar_text = Bus.busList[Bus.selectedBus].name;

  @override
  State<TarangaHomePage> createState() => _TarangaHomePageState();
}

class _TarangaHomePageState extends State<TarangaHomePage> {
  late PermissionStatus _status;

//   void _updateStatus(PermissionStatus value) {
//     setState(() {
//       _status = value;
//     });
//   }
//
//   void _requestPerms() async {
//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.locationWhenInUse,
//       Permission.locationAlways
//     ].request();
//     //  Geolocator.openAppSettings();
//     // openAppSettings();
//     if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
//       _updateStatus(PermissionStatus.limited);
//       // openAppSettings();
//     }
//     // if (await Permission.location.isRestricted) {
//     //   _updateStatus(PermissionStatus.granted);
//     //   openAppSettings();
//     // }
//   }
//
//   runFirst() async {
// //await PermissionHandler()
// //        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
// //        .then(_updateStatus);
//     /* PermissionHandle() deprecated in permission_handler: ^5.0.0+hotfix.3 */
//     await Permission.locationWhenInUse.status.then(_updateStatus);
//     //   Permission.location.isRestricted.then((value) => )
//
//     _requestPerms();
//     if (_status == PermissionStatus.granted) {
//       print("LOcationGaranter anik");
//       // Navigator.push(
//       //     context, MaterialPageRoute(builder: (context) => NextPage()));
//     }
//     // else if (_status == PermissionStatus.denied) {
//     //   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     // }
//     else {
//       // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//       Geolocator.openAppSettings();
//     }
//     // else if (_status == PermissionStatus.limited) {
//     //   Navigator.push(
//     //       context, MaterialPageRoute(builder: (context) => Homepage()));
//     // }
//     //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     // }
//     // else if (_status == PermissionStatus.restricted) {
//     //   Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
//     //  // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     // }
//     // else if (_status == PermissionStatus.permanentlyDenied) {
//     //   Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
//     //   //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//     // }
//   }
//
//   Future<void> myfun() async {
//     if (await Permission.location.serviceStatus.isEnabled) {
//       print("Uses anik");
//     } else if (await Permission.location.serviceStatus.isDisabled) {
//       print(" not Uses anik");
//     } else if (await Permission.location.serviceStatus.isNotApplicable) {
//       print(" not applicable Uses anik");
//     }
//
//     if (await Permission.locationAlways.serviceStatus.isEnabled) {
//       print("service always");
//     } else if (await Permission.locationWhenInUse.serviceStatus.isEnabled) {
//       print("service on use");
//     } else {
//       print(" other cses");
//     }
//   }

  @override
  void initState() {

   // getCurrentLocation().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            TarangaHomePage
                .appbar_text, // Hotel.hotelList[Hotel.selectedHotel].name,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.black,
        ),
        body: Builder(builder: (BuildContext context) {
          return OfflineBuilder(
            connectivityBuilder: (BuildContext context,
                ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    height: 32.0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: connected
                          ? /* Color(0xFF00EE44) */ null
                          : Color(0xFFEE4400),
                      child: connected
                          ? /*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "ONLINE",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )
                           */
                          null
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "OFFLINE",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                SizedBox(
                                  width: 12.0,
                                  height: 12.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              );
            },
            child: TarangaBusBody(),
          );
        }),
        floatingActionButton: AllStaticVariables.gps_share_flag == 1
            ? TarangaFloatingButton()
            : null,
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always) {
        print("always use");
        //return Future.error('Location while in use');
      }


      if (permission == LocationPermission.whileInUse) {
        await Geolocator.openAppSettings();
        print("uing app");
        // return Future.error('Location while in use');
      }

      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        //return Future.error('Location permission denied');
      }
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        //return Future.error('Location permanently denied');
      }
      return await Geolocator.getCurrentPosition();
      //return Future.error('Location service disabled');
    }
    else if(serviceEnabled) {


      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.always) {
        print("always use");
        //return Future.error('Location while in use');
      }

      if (permission == LocationPermission.whileInUse) {
        await Geolocator.openAppSettings();
        print("uing app");
        // return Future.error('Location while in use');
      }

      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        //return Future.error('Location permission denied');
      }
      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();
        //return Future.error('Location permanently denied');
      }
      return await Geolocator.getCurrentPosition();
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
