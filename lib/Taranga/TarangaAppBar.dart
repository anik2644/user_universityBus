import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../SecondaryHomePage/SecondaryBody.dart';
import 'TarangaHomePage.dart';

class TarangaAppbar extends StatefulWidget {
  const TarangaAppbar({Key? key}) : super(key: key);

  @override
  State<TarangaAppbar> createState() => _TarangaAppbarState();
}

class _TarangaAppbarState extends State<TarangaAppbar> {


  @override
  Widget build(BuildContext context) {
    return  AppBar(
      centerTitle: true,
      title: Text(
        TarangaHomePage
            .appbar_text,
        style: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.black,
    );
  }
}
