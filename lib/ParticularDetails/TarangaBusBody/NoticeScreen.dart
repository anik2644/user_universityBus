import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Taranga/TarangaBusBody.dart';


class NoticeScreen extends StatefulWidget {
  // String notice;
  // NoticeScreen( {required this.notice});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
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
}
