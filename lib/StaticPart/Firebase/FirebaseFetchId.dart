import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFetchId{

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

}