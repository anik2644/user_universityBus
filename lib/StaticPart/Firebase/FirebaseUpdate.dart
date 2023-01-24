import 'package:cloud_firestore/cloud_firestore.dart';

import '../BusStaticVariables.dart';
import '../FirabaseStaticVariables.dart';

class FirebaseUpdate{

  static Future<void> updateScheduleArray(String docId, String FieldName) async {

    List<String> locShare=   <String> ['2','0','1','1','1','1','1','1','1'];
    await FirebaseFirestore.instance.collection('schedule').doc(docId).update({
      FieldName: locShare ,
    });

  }

  static Future<void> updateLocshareAndNotice() async {


    await FirebaseFirestore.instance
        .collection('schedule')
        .doc(FirebaseStaticVAriables.selected_schedule_id)
        .update({
      "locShare": BusStaticVariables.locShare,
      'notice': BusStaticVariables.Notice
    });

  }

}