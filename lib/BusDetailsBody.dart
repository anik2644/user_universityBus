import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Livelocationn.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BusDetailsBody extends StatefulWidget {

  static String busName= "kn";
  static String sch= "8.00";
  static String upDown= "up";


  @override
  State<BusDetailsBody> createState() => _BusDetailsBodyState();
}

class _BusDetailsBodyState extends State<BusDetailsBody> {


  var message_type_box_controller = new TextEditingController();
  List<String> Uptrips=   <String> ['0.0','7.02','8.0','7.72','60.0','74.02'];
  List<String> Downtrips=   <String> ['0.0','85.02','7.02','8.0','7.72','60.0','74.02'];

  String just= "just";

  String notic = "No notice so far";


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
    load_data();
  }

  Widget ScheduleButton(String time, String ud) {
    return OutlinedButton(
      onPressed: (){

       // print(time);
       // print(ud);

        BusDetailsBody.busName= Hotel.hotelList[Hotel.selectedHotel].name;
        BusDetailsBody.sch = time;
        BusDetailsBody.upDown =ud;


        Navigator.push(context, MaterialPageRoute(builder: (context) => Livelocationn()));


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

  Widget Notice(){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Icon(Icons.mic, color: kPrimaryColor),
            const SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.4,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding /1.5),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type Notice",
                          border: InputBorder.none,
                          // hintTextDirection: Colors.white,
                        ),
                        controller: message_type_box_controller =
                        new TextEditingController(),
                      ),
                    ),

                    /*
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                    ),
                    */
                    IconButton(
                        onPressed: () async {

                          //  print(message_type_box_controller.text);

                          //- AuthService.ddemeChatMessages.clear();
                          // AuthService.FetchMEssage();

/*
                          final friendUid = "admin";
                          final currentUserId = AuthService.email;
                          var chatDocId;
                          CollectionReference chats = FirebaseFirestore.instance.collection('adminchats');
                          if (message_type_box_controller.text== '') return;

                          await chats
                              .where('users', isEqualTo: {
                            friendUid.toString(): null,
                            currentUserId.toString(): null
                          })
                              .limit(1)
                              .get()
                              .then(
                                (QuerySnapshot querySnapshot) async {
                              if (querySnapshot.docs.isNotEmpty) {
                                //  rreaddata();
                                chatDocId = querySnapshot.docs.single.id;
                                print(chatDocId);
                                //print("dound man");
                              } else {
                                await chats.add({
                                  'users': {
                                    currentUserId.toString(): null,
                                    friendUid.toString(): null,

                                  },
                                  'name' : currentUserId.toString(),
                                }).then((value) => {
                                  chatDocId = value});
                                //   print("Arrogant");
                              }
                            },
                          ).catchError((error) {});

                          chats.doc(chatDocId.toString()).collection('messages').add({
                            'createdOn': FieldValue.serverTimestamp(),
                            'uid':  currentUserId.toString(),
                            'friendName': "admin" ,
                            'msg': message_type_box_controller.text
                          }).then((value) {
                            //_textController.text = '';
                          });

                          AuthService.ddemeChatMessages.add(ChatMessage(
                              message_type_box_controller.text.toString(),
                              ChatMessageType.text,
                              MessageStatus.viewed,
                              true ));



                          // print("message sent done");
                          message_type_box_controller.text = "";

                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) => MessagesScreen()));

*/
                          //  message_type_box_controller.text = "";

                          setState(() {
                            notic= message_type_box_controller.text;
                            message_type_box_controller.text = "";

                          });

                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              ),
            ),
          ],
        ),
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
/*
              Container(
                  margin : EdgeInsets.symmetric(horizontal: 15),
                 // child: Text(description_hotel_sea_crown)
                )
              */
            ],
          ),
        ),
      ),
    );
  }



/*
  Widget allTrips() {
    return Card(
      child: Wrap(
        children: <Widget>[
          ListTile(
              title: Row(
                children: [
                  Text('Trips',style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )),
          Container(
            //margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 150),
            height: MediaQuery.of(context).size.height/3,
            child: Row(
              children: [
                Column(
                  children: [
                    Center(child: Text("Up: ",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),
                    Container(
                     // margin: EdgeInsets.symmetric(vertical: 20.0),
                      //height: 200,//Hotel.hotelList.length* (MediaQuery.of(context).size.width / 2),
                      width: MediaQuery.of(context).size.width / 3,
                      child:  Expanded(
                        child: ListView.builder(
                          //shrinkWrap: true,
                          itemCount: Uptrips.length,
                          itemBuilder: (context, index) => ScheduleButton(
                              Uptrips[index]
                          ),
                        ),
                      ),

                    ),

                   Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                SizedBox(width: 10,),
                Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ],
          ),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),
                    OutlinedButton(
                      child:Container(child: Text('Any Text')),

                      onPressed: () async {


                        //print("object");
                        var chatDocId;
                        CollectionReference Loc = FirebaseFirestore.instance.collection('test');

                        await Loc.where('name', isEqualTo: {
                          'busname': 'srabon',
                         // BusDetailsBody.sc: null,
                        }).limit(1).get().then((QuerySnapshot querySnapshot) async {
                          if (querySnapshot.docs.isNotEmpty) {
                            chatDocId = querySnapshot.docs.single.id;
                            print(chatDocId);
                            print("Got it");
                          } else {
                            print("Vacant Collection");
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

                        var docSnapshot= await FirebaseFirestore.instance.collection("test").doc(chatDocId).get();
                        if (docSnapshot.exists) {

                         // print(docSnapshot.data());
                         // GeoPoint position = docSnapshot.get('currentLocation');
                         // print(position.longitude.toString());
                          // print(docSnapshot.get('sch'));

                         //Uptrips = docSnapshot.get('sch');
                         List.from(docSnapshot.get('sch')).forEach((element){
                           String data = element;

                           //then add the data to the List<Offset>, now we have a type Offset
                           Uptrips.add(data);
                         });

                         print(Uptrips[1]);
                          setState(() {
                          //  llong= position.longitude.toDouble();
                          //  llat =position.latitude.toDouble();

                            just= Uptrips[1];
                          });

                        }


                        // var docSnapshot =  FirebaseFirestore.instance.collection("test").doc(chatDocId).get();
                        // if(docSnapshot!= null)
                        //   {
                        //     print(docSnapshot['sch'].data());
                        //     GeoPoint position = docSnapshot.get('currentLocation');
                        //     print(position.longitude.toString())                              }
                        //     .then((value) => {
                        //  //  value.get(['sch']),
                        //       print(value.data())
                        //   //value.data().forEach((key, value) { })
                        // });




                        FirebaseFirestore.instance.collection("adminchats")
                            .doc(chatdocid)
                            .collection("messages").orderBy('createdOn',  descending: false)
                            .get()
                            .then((subcol) =>
                        {
                          subcol.docs.forEach((element) {
                            var data;
                            data= element.data();


                            ddemeChatMessages.add(ChatMessage( data["msg"].toString() ,ChatMessageType.text,MessageStatus.viewed, data["uid"]==AuthService.email ? true : false));

                            //ChatMessage();
                            // print(msge.text);
                            // print(msge.isSender);
                            // ddemeChatMessages.add(msge);
                            print("hellow world");
                            print(ddemeChatMessages.length);
                            // print(result.id);
                          })
                        });




                        List<Offset> pointList = <Offset>[];

                        getdata() async{
                          await Firestore.instance.collection("test").document('biZV7cepFJA8T6FTcF08').get().then((value){
                            setState(() {
                              // first add the data to the Offset object
                              List.from(value.data['point']).forEach((element){
                                Offset data = new Offset(element);

                                //then add the data to the List<Offset>, now we have a type Offset
                                pointList.add(data);
                              });

                            });
                          });
                        }


                        setState(() {
                          //      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AuthService().handleAuthState()),//AccountPage()),);
                        });}, ),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),

                  ],
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 5,),
                Column(
                  children: [
                    Center(child: Text("Down: ",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),
                    Container(
                      // margin: EdgeInsets.symmetric(vertical: 20.0),
                     // height: 200,//Hotel.hotelList.length* (MediaQuery.of(context).size.width / 2),
                      width: MediaQuery.of(context).size.width / 3,
                      child:  ListView.builder(
                        //shrinkWrap: true,
                        itemCount: Uptrips.length,
                        itemBuilder: (context, index) => ScheduleButton(
                            Uptrips[index]
                        ),
                      ),

                    ),



                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                SizedBox(width: 10,),
                Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                ],
          ),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),
                    OutlinedButton(
                      child:Container(child: Text('Any Text')),
                      onPressed: () async {


                        //print("object");
                        var chatDocId;
                        CollectionReference Loc = FirebaseFirestore.instance.collection('test');

                        await Loc.where('name', isEqualTo: {
                          'busname': 'srabon',
                         // BusDetailsBody.sc: null,
                        }).limit(1).get().then((QuerySnapshot querySnapshot) async {
                          if (querySnapshot.docs.isNotEmpty) {
                            chatDocId = querySnapshot.docs.single.id;
                            print(chatDocId);
                            print("Got it");
                          } else {
                            print("Vacant Collection");
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

                        var docSnapshot= await FirebaseFirestore.instance.collection("test").doc(chatDocId).get();
                        if (docSnapshot.exists) {

                         // print(docSnapshot.data());
                         // GeoPoint position = docSnapshot.get('currentLocation');
                         // print(position.longitude.toString());
                          // print(docSnapshot.get('sch'));

                         //Uptrips = docSnapshot.get('sch');
                         List.from(docSnapshot.get('sch')).forEach((element){
                           String data = element;

                           //then add the data to the List<Offset>, now we have a type Offset
                           Uptrips.add(data);
                         });

                         print(Uptrips[1]);
                          setState(() {
                          //  llong= position.longitude.toDouble();
                          //  llat =position.latitude.toDouble();

                            just= Uptrips[1];
                          });

                        }


                        // var docSnapshot =  FirebaseFirestore.instance.collection("test").doc(chatDocId).get();
                        // if(docSnapshot!= null)
                        //   {
                        //     print(docSnapshot['sch'].data());
                        //     GeoPoint position = docSnapshot.get('currentLocation');
                        //     print(position.longitude.toString())                              }
                        //     .then((value) => {
                        //  //  value.get(['sch']),
                        //       print(value.data())
                        //   //value.data().forEach((key, value) { })
                        // });




                        FirebaseFirestore.instance.collection("adminchats")
                            .doc(chatdocid)
                            .collection("messages").orderBy('createdOn',  descending: false)
                            .get()
                            .then((subcol) =>
                        {
                          subcol.docs.forEach((element) {
                            var data;
                            data= element.data();


                            ddemeChatMessages.add(ChatMessage( data["msg"].toString() ,ChatMessageType.text,MessageStatus.viewed, data["uid"]==AuthService.email ? true : false));

                            //ChatMessage();
                            // print(msge.text);
                            // print(msge.isSender);
                            // ddemeChatMessages.add(msge);
                            print("hellow world");
                            print(ddemeChatMessages.length);
                            // print(result.id);
                          })
                        });



                        setState(() {
                          //      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AuthService().handleAuthState()),//AccountPage()),);
                        });}, ),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),

                  ],
                ),

                Column(
                  children: [
                    Center(child: Text("Down: ",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),
                    OutlinedButton(
                      child:Container(child: Text('Any Text')),
                      onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context) => Livelocationn()));


                        setState(() {

                          //      Navigator.push(context, MaterialPageRoute(builder: (context) =>  AuthService().handleAuthState()),//AccountPage()),);
                        });}, ),

                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),
                    Row(children: [Icon(Icons.lock_clock, size: 20, color: Colors.green,),
                      SizedBox(width: 10,),
                      Text('Trip No:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                    ],
                    ),

                  ],
                ),

              ],
            ),
          ),

          SizedBox(
            height: 35,
            width: double.infinity,
          ),

        ],
      ),
    );
  }
*/




  @override
  Widget build(BuildContext context) {
    return
     /* Column(
      children: [
        description(),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                    //shrinkWrap: true,
                    padding: EdgeInsets.only(left: 5) ,
                    itemCount: Uptrips.length,
                    itemBuilder: (context, index) => ScheduleButton(
                    Uptrips[index]
                )),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: ListView.builder(
                  //shrinkWrap: true,
                    itemCount: Uptrips.length,
                    padding: EdgeInsets.only(right: 5) ,
                    itemBuilder: (context, index) => ScheduleButton(
                        Uptrips[index]
                    )),
              ),

            ],
          ),
        ),
      ],
    );*/
      SingleChildScrollView(
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
                        // "https://cf.bstatic.com/xdata/images/hotel/max1280x900/121123916.jpg?k=4c7205e458ef9d368d14ad4aacd8a45c394110e2b51f2de47a1ffb8d1765cfd6&o=&hp=1"
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
                        //"https://i.travelapi.com/hotels/10000000/9750000/9746600/9746513/b36e79aa_z.jpg"
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

                      // /  chatsData = List.from(chatsData.reversed);
                      //   chatsData.add(  Chat(
                      //     name: Myapp.hotelList[Myapp.selectedHotel].name,
                      //     lastMessage: "Hi,Please let know about us",
                      //     image: Myapp.hotelList[Myapp.selectedHotel].x,
                      //     time: "",
                      //     isActive: true,
                      //   ),);
                      //
                      //   demeChatMessages.add(ChatListObject(Myapp.hotelList[Myapp.selectedHotel].name),);
                      //   chatsData = List.from(chatsData.reversed);
                      //   AuthService.indx= 0;//chatsData.length-1;
                      //
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) =>
                      //           messagesScreenForAllChatMembers(),
                      //     ),
                      //
                      //   );
                      //


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
            Notice(),
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
            //Container(height: 200,color: Colors.black,),
           // Container(height: 200,color: Colors.blue,),
           // allTrips(),
          //ListView.builder(itemBuilder: itemBuilder),
         /* Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: MediaQuery.of(context).size.height/3,
            //color: Colors.black,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                //buttonSection,
               // Popular_facilities(),


               // Text(just,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                //
                // SizedBox(
                //   height: 90,
                // )
              ],
            ),
          ),*/
        ],

        ),
    ),
      );


  }
}
