import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/ParticularDetails/PArticularDetailsHomePAge/ParticularHomepageScaffold.dart';


class TarangaHomePage extends StatefulWidget {


  ParticularHomepageScaffold sCaffold = ParticularHomepageScaffold();

  @override
  State<TarangaHomePage> createState() => _TarangaHomePageState();
}

class _TarangaHomePageState extends State<TarangaHomePage> {


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {

          return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => super.widget));
      },
           child:  widget.sCaffold,
    );
  }
}
