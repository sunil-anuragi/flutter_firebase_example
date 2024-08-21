import 'package:nursecallalram/Services/Pushnotification.dart';
import 'config/import.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  await GetStorage.init();
  await pushNotificationService().setUpInteractedMessage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Mycolor().primarycolor,
      ),
      getPages: Routes.routes,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
    );
  }
}
