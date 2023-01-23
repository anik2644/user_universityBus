import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:userapp/ParticularDetails/TarangaBusBody/ImageSlider.dart';
import 'package:userapp/ParticularDetails/TarangaBusBody/NoticeScreen.dart';
import 'package:userapp/ParticularDetails/TarangaBusBody/TitleScreen.dart';
import 'package:userapp/ParticularDetails/TarangaBusBody/UpDownBuilder.dart';
import '../ParticularDetails/TarangaBusBody/ButtonSection.dart';


class TarangaBusBody extends StatefulWidget {

  TitleScreen tItlescreen= new TitleScreen();
  NoticeScreen nOticescreen = NoticeScreen();
  ImageSlider iMageslider = ImageSlider();
  ButtonSection bUttonSection = ButtonSection();
  UpDownBuilder uPdownbuilder = UpDownBuilder();

  @override
  State<TarangaBusBody> createState() => _TarangaBusBodyState();
}

class _TarangaBusBodyState extends State<TarangaBusBody> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1.3,
        child: Column(
          children: [

            widget.iMageslider,
            widget.tItlescreen,
            const SizedBox(
              width: double.infinity,
              height: 5,
            ),
            widget.bUttonSection,
            widget.nOticescreen,
            widget.uPdownbuilder,
          ],
        ),
      ),
    );
  }





}
