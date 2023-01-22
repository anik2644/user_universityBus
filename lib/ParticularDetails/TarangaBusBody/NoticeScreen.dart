import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../SecondaryHomePage/SecondaryBody.dart';
import '../../Taranga/TarangaBusBody.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeScreen extends StatefulWidget {
  // String notice;
  // NoticeScreen( {required this.notice});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {


  var selectedBusId;


@override
  void initState() {
    // TODO: implement initState
    _getNotice();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        child: Card(
          child: Wrap(
            children: <Widget>[
              ListTile(
                title: Text(
                  TarangaBusBody.Notice
                  ,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }

  Future<void> _getNotice() async {
    CollectionReference schedule =
    FirebaseFirestore.instance.collection('schedule');

    await schedule
        .where('name', isEqualTo: {
      'busName': Bus.busList[Bus.selectedBus].name,
      // currentUserId.toString(): null
    })
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.docs.isNotEmpty) {
        //  rreaddata();
        selectedBusId = querySnapshot.docs.single.id;
        print(selectedBusId);
        //print("dound man");
      } else {}
    });

    await FirebaseFirestore.instance
        .collection("schedule")
        .doc(selectedBusId)
        .snapshots()
        .listen((userData) {
      TarangaBusBody.Notice = userData.data()!['notice'];
    });

    setState(() {

    });
  }


}
