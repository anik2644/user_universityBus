import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/HomePageComponent/Drawer.dart';
import 'package:userapp/HomePageComponent/HomePageBody.dart';
import 'package:userapp/BusDetails/Location_view_templete.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text("App Bar Text")),
      ),
      body: HomePageBody(),
      drawer: Mydrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openDialouge();
        },
      ),
    );
  }

  Future openDialouge() => showDialog(
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
                      decoration:InputDecoration(hintText: "ennterYouNamer",) ,
                    ),
                    SizedBox(height: 10,),
                    TextField(

                      decoration:InputDecoration(hintText: "ennterYouNamer",) ,
                    ),
                    TextButton(onPressed: (){
                      print("already pressed");
                    }, child: Text("Submit")),
                  ],
                ),
              )
          )));


}
