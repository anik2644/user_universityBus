import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:userapp/BusDetails/Location_view_templete.dart';
import 'package:userapp/HomePageComponent/HomePage.dart';
import 'package:userapp/HomePageComponent/HomePageBody.dart';
import 'package:userapp/Taranga/TarangaHomePage.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loc;

import '../constants.dart';

class TarangaBusBody extends StatefulWidget {

  static String busName= "kn";
  static String sch= "8.00";
  static String upDown= "up";

  static List<String> locShare=   <String> ['0','1','1','1','1','0','1','1','1'];


  @override
  State<TarangaBusBody> createState() => _TarangaBusBodyState();
}

class _TarangaBusBodyState extends State<TarangaBusBody> {


  var _noticeController = new TextEditingController();
  var _passCodeController = new TextEditingController();
    //_noticeController
  List<String> Uptrips=   <String> ['0.0','7.02','8.0','7.72','60.0','74.02'];
  List<String> Downtrips=   <String> ['0.0','85.02','7.02','8.0','7.72','60.0','74.02'];

  String notic = "No notice so far";

  var selectedBusId;



void _liveLocation() {


    LocationSettings locationSettings = LocationSettings(
      //accuracy: LocationAccuracy.high,
      distanceFilter: 1,

    );

    print('AllStaticVariables.mapshareflag:  $AllStaticVariables.mapshareflag');
    print(AllStaticVariables.mapshareflag);

    // if (AllStaticVariables.mapshareflag == 1) {
    //  print("with come");

    Geolocator.getPositionStream(locationSettings: locationSettings).listen((
        Position position) async {
      print('AllStaticVariables.mapshareflag:  $AllStaticVariables.mapshareflag');
      print(AllStaticVariables.gps_share_flag);

      if (AllStaticVariables.gps_share_flag == 1) {

        print("with come");
        int time_flag=1;

        DateTime current_time = new DateTime.now();

        if(current_time.year>AllStaticVariables.start_time.year)
        {
          time_flag =0;
        }
        else if(current_time.month>AllStaticVariables.start_time.month)
        {
          time_flag =0;
        }
        else if(current_time.day>AllStaticVariables.start_time.day)
        {
          time_flag =0;
        }
        else if(current_time.hour>AllStaticVariables.start_time.hour+4)
        {
          time_flag =0;
        }

        //
        // else if(current_time.minute>AllStaticVariables.start_time.minute)
        // {
        //   time_flag =0;
        // }

        if(time_flag==0)
        {
          AllStaticVariables.gps_share_flag=0;
          print("app will restart");
        }
        print(AllStaticVariables.selectedtrip);


        await FirebaseFirestore.instance.collection("Location").doc(
            AllStaticVariables.selectedtrip).update({
          'currentLocation': GeoPoint(position.latitude, position.longitude)
        });








        //  }


        setState(() {
          // print('$lat');
          // print('$long');
          //mystr = 'lat: $lat , lon: $long';
          // current = LatLng(position.latitude, position.longitude);
        });
      }

    });
    // }

  }

  // LocationData?  currentlocation ;
Future<Position> getCurrentLocation() async
  {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled)
    {
      LocationPermission permission = await Geolocator.checkPermission();
      if(permission==LocationPermission.denied)
      {
        return Future.error('Location permission denied');
      }
      if(permission== LocationPermission.deniedForever)
      {
        return Future.error('Location permanently denied');
      }
      return await Geolocator.getCurrentPosition();
      //return Future.error('Location service disabled');
    }


    LocationPermission permission = await Geolocator.checkPermission();
    if(permission==LocationPermission.denied)
    {
      permission = await Geolocator.requestPermission();
      if(permission== LocationPermission.denied)
      {
        return Future.error('Location permission denied');
      }
    }
    if(permission== LocationPermission.deniedForever)
    {
      return Future.error('Location permanently denied');
    }
    return await Geolocator.getCurrentPosition();
  }



Future<void> _getNotice() async {

    CollectionReference schedule = FirebaseFirestore.instance.collection('schedule');

    await schedule.where('name', isEqualTo: {
      'busName': Hotel.hotelList[Hotel.selectedHotel].name,
      // currentUserId.toString(): null
    }).limit(1)
        .get()
        .then(
            (QuerySnapshot querySnapshot) async {
          if (querySnapshot.docs.isNotEmpty) {
            //  rreaddata();
            selectedBusId = querySnapshot.docs.single.id;
            print(selectedBusId);
            //print("dound man");
          } else {}
        });

        await FirebaseFirestore.instance.collection("schedule").doc(selectedBusId).snapshots().listen((userData) {

          notic = userData.data()!['notice'];
      // setState(() {
      //   myId = userData.data()['uid'];
      //   myUsername = userData.data()['name'];
      //   myUrlAvatar = userData.data()['avatarurl'];
      //
      // });
    });



    // var docSnapshot= await FirebaseFirestore.instance.collection("schedule").doc(selectedBusId).get();
    // if (docSnapshot.exists) {
    //   docSnapshot.data([notice]);
    //   docSnapshot.data()?.forEach((key, value) {
    //
    //     print(value);
    //   });




      // //print(Uptrips);
      // setState(() {
      //   //  llong= position.longitude.toDouble();
      //   //  llat =position.latitude.toDouble();
      //
      // });

    }

Future<void> load_data() async {
  // print(Hotel.hotelList[Hotel.selectedHotel].name);
  Uptrips.clear();
  Downtrips.clear();
  TarangaBusBody.locShare.clear();

  CollectionReference Loc = FirebaseFirestore.instance.collection('schedule');

  await Loc.where('name', isEqualTo: {
    'busName': Hotel.hotelList[Hotel.selectedHotel].name,
    // BusDetailsBody.sc: null,
  }).limit(1).get().then((QuerySnapshot querySnapshot) async {
    if (querySnapshot.docs.isNotEmpty) {
      AllStaticVariables. chatDocId = querySnapshot.docs.single.id;
      // print(chatDocId);
      //  print("Got it");
    } else {
      // print("Vacant Collection");
      // await Loc.add({
      //   'trip': {
      //     BusDetailsBody.name: null,
      //     BusDetailsBody.sc: null,
      //
      //   },
      //   'currentLocation' : GeoPoint(value.latitude,value.longitude),
      // }).then((value) => {
      //   chatDocId = value});
      // //   print("Arrogant");
    }
  },
  ).catchError((error) {});


  var docSnapshot= await FirebaseFirestore.instance.collection("schedule").doc(AllStaticVariables.chatDocId).get();
  if (docSnapshot.exists) {
    List.from(docSnapshot.get('up')).forEach((element){
      String data = element;
      Uptrips.add(data);
    });
    List.from(docSnapshot.get('down')).forEach((element){
      String data = element;
      Downtrips.add(data);
    });
    List.from(docSnapshot.get('locShare')).forEach((element){
      String data = element;
      TarangaBusBody.locShare.add(data);
    });
    setState(() {});
  }
}
/*
Future<void> locShareFlag() async {

    var chatDocId;
    CollectionReference Loc = FirebaseFirestore.instance.collection('schedule');

    await Loc.where('name', isEqualTo: {
      'busName': Hotel.hotelList[Hotel.selectedHotel].name,
      // BusDetailsBody.sc: null,
    }).limit(1).get().then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        chatDocId = querySnapshot.docs.single.id;
        // print(chatDocId);
        //  print("Got it");
      } else {
        // print("Vacant Collection");
        // await Loc.add({
        //   'trip': {
        //     BusDetailsBody.name: null,
        //     BusDetailsBody.sc: null,
        //
        //   },
        //   'currentLocation' : GeoPoint(value.latitude,value.longitude),
        // }).then((value) => {
        //   chatDocId = value});
        // //   print("Arrogant");
      }
    },
    ).catchError((error) {});

    // print(chatDocId);
    //  print("object1");

    var docSnapshot= await FirebaseFirestore.instance.collection("schedule").doc(chatDocId).get();
    if (docSnapshot.exists) {

      // print(docSnapshot.data());
      // GeoPoint position = docSnapshot.get('currentLocation');
      // print(position.longitude.toString());
      // print(docSnapshot.get('sch'));

      //Uptrips = docSnapshot.get('sch');
      List.from(docSnapshot.get('locShare')).forEach((element){
        String data = element;

        // print(element.toString());
        //then add the data to the List<Offset>, now we have a type Offset
        locShare.add(data);
      });



      //print(Uptrips);
      setState(() {
        //  llong= position.longitude.toDouble();
        //  llat =position.latitude.toDouble();

        //just= Uptrips[1];
      });

    }


  }

*/
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
                      decoration:InputDecoration(hintText: "Type Any Notice",) ,
                      controller: _noticeController,
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: _passCodeController,
                      decoration:InputDecoration(hintText: "PassCode",) ,
                    ),
                    TextButton(onPressed: () async {



                      int flag =0;
                      for(int i=0;i< _noticeController.text.length;i++)
                        {
                          if(_noticeController.text.codeUnitAt(i)>64&&_noticeController.text.codeUnitAt(i)<91||_noticeController.text.codeUnitAt(i)>96&&_noticeController.text.codeUnitAt(i)<123)
                         {
                           flag =1;
                           break;
                         }
                        }
                      if(flag==1)
                        {
                          notic =_noticeController.text;
                        }
                   //Notice set done



                    //  locShare.add("0");
                      //print(locShare.length);
                      TarangaBusBody.locShare[index]="0";
                      AllStaticVariables.location_share_schedule_index = index;
                      print(AllStaticVariables.chatDocId);
                      await FirebaseFirestore.instance.collection('schedule').doc(AllStaticVariables.chatDocId)
                          .update({
                        "locShare": TarangaBusBody.locShare ,
                        'notice' : notic
                      });




                      //gpsshereflag

                      if(AllStaticVariables.gps_share_flag==0)
                      {
                        loc.Location location = new loc.Location();
                        location.enableBackgroundMode(enable: true);
                        print(location.getLocation().then((value) => print(value.longitude)));
                        await location.changeSettings(accuracy: loc.LocationAccuracy.high,distanceFilter: 1);



                        if(AllStaticVariables.gps_share_flag==0)
                        {

                          print("Hey I Have Come Here");
                          CollectionReference Loc = FirebaseFirestore.instance.collection('Location');
                          await Loc.where('trip', isEqualTo: {
                            AllStaticVariables.busName: null,
                            AllStaticVariables.sch: null,
                            AllStaticVariables.upDown: null,
                          }).limit(1).get().then((QuerySnapshot querySnapshot) async {
                            if (querySnapshot.docs.isNotEmpty) {
                              // chatDocId = querySnapshot.docs.single.id;
                              AllStaticVariables.selectedtrip = querySnapshot.docs.single.id;
                              // print("object");
                              print( AllStaticVariables.selectedtrip);
                              print("Got it");
                            } else {
                              print("vacant");
                              await Loc.add({
                                'trip': {
                                  AllStaticVariables.busName: null,
                                  AllStaticVariables.sch: null,
                                  AllStaticVariables.upDown: null,
                                },
                                'currentLocation' : GeoPoint(34.4,90.4),
                              }).then((value) => {
                                //chatDocId = value.id,
                                AllStaticVariables.selectedtrip= value.id,
                                print("my"),
                                print( AllStaticVariables.selectedtrip)
                              });
                              //   print("Arrogant");
                            }
                          },
                          ).catchError((error) {});
                        }


                        AllStaticVariables.locationSubscription= location.onLocationChanged.listen((loc.LocationData currentLocation) async {

                          if (AllStaticVariables.gps_share_flag == 1) {

                           // print("with come");
                            int time_flag=1;

                            DateTime current_time = new DateTime.now();

                            if(current_time.year>AllStaticVariables.start_time.year)
                            {
                              time_flag =0;
                            }
                            else if(current_time.month>AllStaticVariables.start_time.month)
                            {
                              time_flag =0;
                            }
                            else if(current_time.day>AllStaticVariables.start_time.day)
                            {
                              time_flag =0;
                            }
                            else if(current_time.hour>AllStaticVariables.start_time.hour+4)
                            {
                              time_flag =0;
                            }

                            //
                            // else if(current_time.minute>AllStaticVariables.start_time.minute)
                            // {
                            //   time_flag =0;
                            // }

                            if(time_flag==0)
                            {
                              loc.Location.instance.enableBackgroundMode(enable: false);
                              AllStaticVariables.locationSubscription.cancel();

                              AllStaticVariables.gps_share_flag=0;
                              print("app will restart");
                            }
                            print(AllStaticVariables.selectedtrip);

                            setState(() {});
                          }


                          print(AllStaticVariables.selectedtrip);
                          print("object");
                          await FirebaseFirestore.instance.collection("Location").doc(
                              AllStaticVariables.selectedtrip).update({
                            'currentLocation': GeoPoint(currentLocation.latitude!, currentLocation.longitude!)
                          });



                          AllStaticVariables.gps_share_flag=1;
                          AllStaticVariables.start_time = new DateTime.now();


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
                          setState(() {});
                        });
                      }

                      //hello

                      /*
                      else{
                        loc.Location.instance.enableBackgroundMode(enable: false);
                        AllStaticVariables.locationSubscription.cancel();
                        //Location.instance.serviceEnabled().then((value) => null);
                      }
                       */
                      //
                      //   getCurrentLocation().then((value) async {
                      //   AllStaticVariables.mapshareflag=1;
                      //   AllStaticVariables.gps_share_flag=1;
                      //   AllStaticVariables.start_time = new DateTime.now();
                      //   _liveLocation();
                      // });

                      setState(() {});
                      AllStaticVariables.gps_share_flag =1;
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => TarangaHomePage()));
                    //  Navigator.pop(context);
                      print("already pressed");
                    }, child: Text("Submit")),
                  ],
                ),
              )
          )));




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotice();
    load_data();
    //locShareFlag();
  }

  Widget ScheduleButton(int index,String time, String ud) {
    return Container(
     // color: Colors.cyanAccent,
      child: Row(
        children: [
          SizedBox(width: 6,),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: ud == "down" ?BorderSide(width: 5.0, color: Colors.black26):
              TarangaBusBody.locShare[index]=="1" ? BorderSide(width: 5.0, color: Colors.blue):
              TarangaBusBody.locShare[index]=="0" ? BorderSide(width: 5.0, color: Colors.green):BorderSide(width: 5.0, color: Colors.black26) ,
            ),
              onPressed: ud == "down" ? null:  TarangaBusBody.locShare[index]=="0"? ()
            {
              // print(time);
              // print(ud);
              TarangaBusBody.busName= "Taranga";//Hotel.hotelList[Hotel.selectedHotel].name;
              TarangaBusBody.sch = time;
              TarangaBusBody.upDown =ud;
              Navigator.push(context, MaterialPageRoute(builder: (context) => LocationView()));


              setState(() {

              });

            }: TarangaBusBody.locShare[index]=="1"? (){

              AllStaticVariables.upDown=ud;
              AllStaticVariables.sch=time;

                openDialouge(index);

              }:null,
            child: Text(time,style: TextStyle(fontSize: 25, color:Colors.blue ),),
          ),
          SizedBox(width: 6,),
        ],
      ),
    );
  }

  Widget titleSection(){
    return Container(
      padding: EdgeInsets.only(right: 32, left: 32, top: 0, bottom: 0),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  //padding:  EdgeInsets.only(bottom: 8),
                  child: Text(
                    Hotel.hotelList[Hotel.selectedHotel].name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.green,
                    ),
                    Text(
                      Hotel.hotelList[Hotel.selectedHotel].address,
                      style: TextStyle(
                          color: Colors.grey[500], fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          /*   FavoriteButton(
            isFavorite: false,
            // iconDisabledColor: Colors.white,
            valueChanged: (_isFavorite) {
              bodyFavorite.favList.add(Myapp.selectedHotel);
              print('Is Favorite : $_isFavorite');
            },
          ),

        */
          /*
        IconButton(

            icon: Icon(
              Icons.favorite,
              color: _selectedIndex != null && _selectedIndex == position
                  ? Colors.redAccent
                  : Colors.grey,
            ),
            onPressed: (){

              _onSelected(position);
            }
        )

         */
        ],
      ),
    );
  }

  GestureDetector description() {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        child: Card(
          child: Wrap(
            children: <Widget>[



              ListTile(
                title: Text( notic//Hotel.hotelList[Hotel.selectedHotel].description
                  /*'Hotel Description'*/
                  ,style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*1.3,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height/4,
                width: double.infinity,
                child: CarouselSlider(
                  items: [
                    //1st Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              Hotel.hotelList[Hotel.selectedHotel].x),
                          //"https://hotelseacrownbd.com/wp-content/uploads/2017/07/Presidential-Suite_Hotel-Sea-Crown_Cox-Bazar-14-570x400.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              Hotel.hotelList[Hotel.selectedHotel].y
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //3rd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              Hotel.hotelList[Hotel.selectedHotel].z
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                  ],

                  //Slider Container properties
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 600),
                    viewportFraction: 0.8,
                  ),
                ),
              ),
              titleSection(),
              const SizedBox(
                width: double.infinity,
                height: 5,
              ),
              Card(
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [

                    IconButton(

                      icon: Icon(

                        color: Colors.blue,

                        Icons.call,

                      ),

                      onPressed: () async {
                        //     FlutterPhoneDirectCaller.callNumber(hotel_number);
                      },

                    ),

                    IconButton(

                      icon: Icon(

                        color: Colors.blue,

                        Icons.chat,

                      ),

                      onPressed: () {

                      },

                    ),

                    IconButton(

                      icon: Icon(

                        color: Colors.blue,

                        Icons.location_on,

                      ),

                      onPressed: () {
                        AlertDialog alert = AlertDialog(
                          title: Text('Location:'),
                          content: Text( Hotel.hotelList[Hotel.selectedHotel].location),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },

                    ),

                  ],

                ),
              ),
              description(),
              Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  ListTile(
                    title: Text( "Up Trips:"//Hotel.hotelList[Hotel.selectedHotel].description
                      /*'Hotel Description'*/
                      ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  //  ListTile( Text("Up Trips:",style: TextStyle(fontSize: 20,),textAlign: TextAlign.left,)),
                  // SizedBox(height: 30,),

                  Container(
                    height: 100,
                    child: ListView.builder(
                      //shrinkWrap: true,
                        scrollDirection: Axis.horizontal,

                        padding: EdgeInsets.only(left: 25,right: 25,top: 5) ,
                        itemCount: Uptrips.length,
                        itemBuilder: (context, index) => ScheduleButton(index,
                          Uptrips[index],"up",
                        )),
                  ),



                  // Container(
                  //   height: 100,
                  //   child: Expanded(
                  //     child: ListView.builder(
                  //       //shrinkWrap: true,
                  //         scrollDirection: Axis.horizontal,
                  //
                  //         padding: EdgeInsets.only(left: 25,right: 25,top: 5) ,
                  //         itemCount: Uptrips.length,
                  //         itemBuilder: (context, index) => ScheduleButton(index,
                  //           Uptrips[index],"up",
                  //         )),
                  //   ),
                  // ),
                  // SizedBox(height: 30,),
                  ListTile(
                    title: Text( "Down Trips:"//Hotel.hotelList[Hotel.selectedHotel].description
                      /*'Hotel Description'*/
                      ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  ),
                  // Card(child: Text("Down Trips:",style: TextStyle(fontSize: 20),)),
                  // SizedBox(height: 30,),

                  Container(
                    height: 100,
                    child: ListView.builder(
                      //shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: Downtrips.length,
                        padding: EdgeInsets.only(right: 25,left: 25,top: 10) ,
                        itemBuilder: (context, index) => ScheduleButton( index,
                            Downtrips[index],"down"
                        )),
                  ),
                  // Container(
                  //   height: 100,
                  //   child: Expanded(
                  //     child: ListView.builder(
                  //       //shrinkWrap: true,
                  //         scrollDirection: Axis.horizontal,
                  //         itemCount: Downtrips.length,
                  //         padding: EdgeInsets.only(right: 25,left: 25,top: 10) ,
                  //         itemBuilder: (context, index) => ScheduleButton( index,
                  //             Downtrips[index],"down"
                  //         )),
                  //   ),
                  // ),
                ],
              ),
            ],

          ),
        ),
      );


  }
}
