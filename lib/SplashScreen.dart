import 'dart:async';

import 'config/import.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Authctrl authctrl = Get.put(Authctrl());
  @override
  void initState() {
   navifation();
    super.initState();
  }

 navifation() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Timer(Duration(seconds: 3), () => Get.toNamed(AppRoutes.login));
    } else {
      Usermodel? userdata =
          await authctrl.Getuserdetailsbyuid(FirebaseAuth.instance.currentUser!.uid);
      if (userdata!.usertype == Strings.patient) {
       
        Timer(
            Duration(seconds: 3), () => Get.toNamed(AppRoutes.usergenerateemg));
      } else {
        Timer(Duration(seconds: 3), () => Get.toNamed(AppRoutes.allalarmlist));
      }
    }
    print(FirebaseAuth.instance.currentUser.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Mycolor().primarycolor, Mycolor().secondrycolor]),
        ),
        child: Text(
          Strings.Appname.toString().toUpperCase(),
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 5),
        ),
      ),
    );
  }
}
