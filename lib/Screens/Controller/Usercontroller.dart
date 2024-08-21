import 'package:nursecallalram/Model/Emergencymodel.dart';
import 'package:nursecallalram/Services/Pushnotification.dart';

import '../../config/import.dart';

class Userctrl extends GetxController {
  TextEditingController roomno = TextEditingController();
  TextEditingController emgdes = TextEditingController();

  addEmergency(cntx) async {
    Emergencymodel emgdata = Emergencymodel(
      id: "",
      emgdes: emgdes.text,
      nurseid: "",
      roomno: roomno.text,
      attendstatus: 0,
    );
    var result = await FirebaseCrud().insertIntoCollection(
        collectionname: FirebaseCollectionname.emg, jsondata: emgdata.toJson());
    if (result != null) {
      await FirebaseCrud().updateCollectiondata(
          docid: result.id,
          collectionname: FirebaseCollectionname.emg,
          jsondata: {"id": result.id});
      clearallfield();
      Get.toNamed(AppRoutes.usergenerateemg);
      Utils().toast(message: Strings.emgsent);
      pushNotificationService().shownotification(Strings.sent,Strings.emersend);
      print("Emergency Sent");
      clearallfield();
    }
  }

  clearallfield() {
    roomno.clear();
    emgdes.clear();
  }
}
