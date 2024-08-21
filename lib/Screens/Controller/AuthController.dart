import '../../config/import.dart';
import 'package:get_storage/get_storage.dart';
class Authctrl extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController conPassword = TextEditingController();
  List<String> usertype = [Strings.patient, Strings.nurse];
  String? selecteduser;
  UserCredential? user;

  signup(cntx) async {
    var resultofemail = await FirebaseAuthfunction()
        .reistertofirebase(email.text, password.text);
    print("register data" + resultofemail.toString());
    if (resultofemail != false) {
      user = resultofemail;
      Usermodel userdata = Usermodel(
          id: "",
          uid: user!.user!.uid.toString(),
          email: email.text,
          password: password.text,
          username: username.text,
          usertype: selecteduser!);
      var result = await FirebaseCrud().insertIntoCollection(
          collectionname: FirebaseCollectionname.user,
          jsondata: userdata.toJson());
      if (result != null) {
        await FirebaseCrud().updateCollectiondata(
            docid: result.id,
            collectionname: FirebaseCollectionname.user,
            jsondata: {"id": result.id});
        clearallfield();
        if (selecteduser == Strings.patient) {
          Get.toNamed(AppRoutes.usergenerateemg);
        } else {
          Get.toNamed(AppRoutes.allalarmlist);
        }
        user = resultofemail;
        GetStorage().write("userdocid", result.id);
        print("Added successfully");
      }
    }
  }

  clearallfield() {
    email.clear();
    username.clear();
    password.clear();
    conPassword.clear();
  }

  SigIn(cntx) async {
    var resultofemail =
        await FirebaseAuthfunction().logintoFirebase(email.text, password.text);
    print("result" + resultofemail.toString());
    if (resultofemail != false) {
      print("result data" + resultofemail.toString());
      Usermodel? userdata = await Getuserdetailsbyuid(resultofemail.user.uid);
      if (userdata!.usertype == Strings.patient) {
        Get.toNamed(AppRoutes.usergenerateemg);
      } else {
        Get.toNamed(AppRoutes.allalarmlist);
      }
      clearallfield();
      GetStorage().write("userdocid", userdata.id);
      user = resultofemail;
      print("login successfully");
    }
  }

  signout() async {
    await FirebaseAuthfunction().logoutTofirebase();
    Get.toNamed(AppRoutes.login);
  }

  Future<Usermodel?> Getuserdetailsbyuid(id) async {
    QuerySnapshot snapshot = await FirebaseCrud().getfromcollectionwhere(
        collectionname: FirebaseCollectionname.user,
        fieldname: "uid",
        fieldvalue: id);

    Usermodel? result;
    snapshot.docs.forEach((doc) {
      result = Usermodel(
          id: doc['id'],
          username: doc['username'],
          uid: doc['uid'],
          email: doc['email'],
          password: doc['password'],
          usertype: doc['userType']);
    });

    return result;
  }
}
