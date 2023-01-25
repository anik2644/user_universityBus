import 'dart:async';
import 'BusStaticVariables.dart';
import 'FirabaseStaticVariables.dart';
import 'Firebase/FirebaseFetchId.dart';
import 'Firebase/FirebaseReadArray.dart';
import 'package:location/location.dart';

class ModelStatic{

  static String particularAppbarText = "Appbar";
  static int gps_share_flag = 0;
  static late int location_share_schedule_index;
  static late StreamSubscription<LocationData> locationSubscription;
  static DateTime start_time = new DateTime.now();

  static int locSharePopupFlag = 0;



   static Future<void> particularBusDataLoad() async {

    FirebaseStaticVAriables.isLoading = false;
    FirebaseStaticVAriables.selected_schedule_id = await FirebaseFetchId.getScheduleDocID(BusStaticVariables.busName) as String;
    await FirebaseReadArray.loadNoticeAndTripswithFlag();
    FirebaseStaticVAriables.isLoading = true;
  }
}