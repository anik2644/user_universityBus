import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../StaticPart/Firebase/FirebaseRead.dart';

class HomePageFloatingButtion extends StatefulWidget {
  const HomePageFloatingButtion({Key? key}) : super(key: key);

  @override
  State<HomePageFloatingButtion> createState() => _HomePageFloatingButtionState();
}

class _HomePageFloatingButtionState extends State<HomePageFloatingButtion> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {


        String docid= await FirebaseDataRead.getScheduleDocID("Taranga") as String;
        //print(docid);
        FirebaseDataRead.updateScheduleArray(docid,"locShare");

      },
      child: Icon(Icons.refresh,color: Colors.white,),
      backgroundColor: Colors.black,
    );
  }
}
