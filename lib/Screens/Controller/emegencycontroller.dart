import '../../config/import.dart';
import 'package:get_storage/get_storage.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class Emergencyctrl extends GetxController {
  @override
  void onInit() {
    openassetsaudio();
    super.onInit();
  }

  allcalls() {
    return FirebaseCrud().getfromcollectiondoublewheresnapshots(
        collectionname: FirebaseCollectionname.emg,
        fieldname1: "attendstatus",
        fieldvalue1: 0,
        fieldname: "nurseid",
        fieldvalue: "");
  }

  callbyid() {
    return FirebaseCrud().getfromcollectionwheresnapshots(
        collectionname: FirebaseCollectionname.emg,
        fieldname: "nurseid",
        fieldvalue: GetStorage().read("userdocid"));
  }

  updatecalls(id, status) async {
    try {
      FirebaseCrud().updateCollectiondata(
          docid: id,
          collectionname: FirebaseCollectionname.emg,
          jsondata: {
            "attendstatus": status,
            "nurseid": GetStorage().read("userdocid")
          });
      if (status == 1) {
        Utils().toast(message: Strings.accept);
      } else {
        Utils().toast(message: Strings.rejected);
      }
    } catch (e) {
      Utils().toast(message: e.toString());
    }
  }

  //create a new player
  final assetsAudioPlayer = AssetsAudioPlayer();

  openassetsaudio() async {
    try {
      await assetsAudioPlayer.open(
        Audio("assets/emergency.mp3"),
        autoStart: false
      );
    } catch (t) {
      Utils().toast(message: "mp3 unreachable");
    }
  }
}
