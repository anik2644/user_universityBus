import 'BusStaticVariables.dart';
import 'FirabaseStaticVariables.dart';
import 'Firebase/FirebaseFetchId.dart';
import 'Firebase/FirebaseReadArray.dart';

class ModelStatic{

   static Future<void> particularBusDataLoad() async {

    FirebaseStaticVAriables.isLoading = false;
    FirebaseStaticVAriables.selected_schedule_id = await FirebaseFetchId.getScheduleDocID(BusStaticVariables.busName) as String;
    await FirebaseReadArray.loadNoticeAndTripswithFlag();
    FirebaseStaticVAriables.isLoading = true;
  }
}