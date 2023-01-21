import '../SecondaryHomePage/SecondaryBody.dart';
import '../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDataRead{

  static Future<String> getScheduleDocID(String busName) async
  {
      String docId = "nothing here";

      await FirebaseFirestore.instance.collection('schedule').where('name', isEqualTo: {'busName': busName}).limit(1).get().
      then((QuerySnapshot querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          docId = querySnapshot.docs.single.id;
        } else {
          print("no data found");
        }
      }).catchError((error) {});

      return docId;
  }

  static Future<void> updateScheduleArray(String docId, String FieldName) async {

    List<String> locShare=   <String> ['2','0','1','1','1','1','1','1','1'];
    await FirebaseFirestore.instance.collection('schedule').doc(docId).update({
      FieldName: locShare ,
    });

  }

}