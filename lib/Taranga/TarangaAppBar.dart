import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../SecondaryHomePage/SecondaryBody.dart';

class TarangaAppbar extends StatefulWidget {
  const TarangaAppbar({Key? key}) : super(key: key);

  @override
  State<TarangaAppbar> createState() => _TarangaAppbarState();
}

class _TarangaAppbarState extends State<TarangaAppbar> {


  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        Hotel.hotelList[Hotel.selectedHotel].name,
        style: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.black,
    );
  }
}
