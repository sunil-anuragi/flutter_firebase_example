import 'package:nursecallalram/Screens/EmergencyGenerate/UsergenerateEmg.dart';

import '../Screens/Allalrams/Callhistory.dart';
import '../Screens/Allalrams/allAlarmlist.dart';
import '../SplashScreen.dart';
import '../config/import.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen(),transition: Transition.leftToRightWithFade),
    GetPage(name: AppRoutes.login, page: () => LoginScreen(),transition: Transition.leftToRightWithFade),
    GetPage(name: AppRoutes.allalarmlist, page: () => Allalarmlist(),transition: Transition.leftToRightWithFade),
    GetPage(name: AppRoutes.usergenerateemg, page: () => Usergenerateemg(),transition: Transition.leftToRightWithFade),
    GetPage(name: AppRoutes.callHistory, page: () => CallHistory(),transition: Transition.leftToRightWithFade),
  ];
}
