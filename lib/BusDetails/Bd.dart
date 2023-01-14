import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:userapp/BusDetails/Location_view_templete.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BD extends StatefulWidget {

  static String busName= "kn";
  static String sch= "8.00";
  static String upDown= "up";


  @override
  State<BD> createState() => _BDState();
}

class _BDState extends State<BD> {


  var message_type_box_controller = new TextEditingController();
  List<String> Uptrips=   <String> ['0.0','7.02','8.0','7.72','60.0','74.02'];
  List<String> Downtrips=   <String> ['0.0','85.02','7.02','8.0','7.72','60.0','74.02'];

  String just= "just";

  String notic = "No notice so far";


  var selectedBusId;

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
    List.from(docSnapshot.get('up')).forEach((element){
      String data = element;

      //then add the data to the List<Offset>, now we have a type Offset
      Uptrips.add(data);
    });

    List.from(docSnapshot.get('down')).forEach((element){
      String data = element;

      //then add the data to the List<Offset>, now we have a type Offset
      Downtrips.add(data);
    });




    //print(Uptrips);
    setState(() {
      //  llong= position.longitude.toDouble();
      //  llat =position.latitude.toDouble();

      just= Uptrips[1];
    });

  }


}

 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNotice();
    load_data();
  }

  Widget ScheduleButton(String time, String ud) {
    return OutlinedButton(
      onPressed: (){

        // print(time);
        // print(ud);

        BD.busName= Hotel.hotelList[Hotel.selectedHotel].name;
        BD.sch = time;
        BD.upDown =ud;


        Navigator.push(context, MaterialPageRoute(builder: (context) => LocationView()));


        setState(() {

        });

      },
      child: Text(time),
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
              Container(
                //  height: 500,//MediaQuery.of(context).size.height,

                child: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          //shrinkWrap: true,
                            padding: EdgeInsets.only(left: 5,right: 25) ,
                            itemCount: Uptrips.length,
                            itemBuilder: (context, index) => ScheduleButton(
                              Uptrips[index],"up",
                            )),
                      ),
                      SizedBox(width: 30,),
                      Expanded(
                        child: ListView.builder(
                          //shrinkWrap: true,
                            itemCount: Downtrips.length,
                            padding: EdgeInsets.only(right: 5,left: 25) ,
                            itemBuilder: (context, index) => ScheduleButton(
                                Downtrips[index],"down"
                            )),
                      ),

                    ],
                  ),
                ),
              ),
            ],

          ),
        ),
      );


  }
}
