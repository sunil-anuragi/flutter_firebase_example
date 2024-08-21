import '../../config/import.dart';

import 'Component/CallListbuilder.dart';
import 'Component/coloridentifier.dart';

class Allalarmlist extends StatefulWidget {
  const Allalarmlist({super.key});

  @override
  State<Allalarmlist> createState() => _AllalarmlistState();
}

class _AllalarmlistState extends State<Allalarmlist> {
  Authctrl authctrl = Get.put(Authctrl());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
                radius: 17,
                backgroundColor: Mycolor().whitecolor,
                child: Center(
                    child: Icon(
                  Icons.alarm,
                  color: Mycolor().red,
                ))).paddingOnly(right: 10),
            Text(Strings.allalarm),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.power_settings_new_sharp,
              color: Mycolor().whitecolor,
            ),
            onPressed: () async {
              await authctrl.signout();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
                color: Mycolor().primarycolor.withOpacity(0.6),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                )),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Text(
                        Strings.welcome +
                            ", " +
                            FirebaseAuth.instance.currentUser!.email
                                .toString()
                                .split("@")[0],
                        // authctrl.user!.user!.email.toString().split("@")[0],
                        style: TextStyle(
                            fontSize: 24.0,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            color: Mycolor().blackcolor.withOpacity(0.7))),
                    const SizedBox(height: 10.0),
                    Text("Here are your all call",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Mycolor().blackcolor.withOpacity(0.7))),
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          child: Text(
                            Strings.history,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white70),
                          ),
                          onPressed: () {
                            Get.toNamed(AppRoutes.callHistory);
                          }),
                    ),
                    CallListbuilder(),
                    SizedBox(height: 30.0),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ColorIdentifier(
                              color: Mycolor().Gray, service: "Actice Call"),
                          ColorIdentifier(
                              color: Mycolor().green, service: "Accepted Call"),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ColorIdentifier(
                            color: Mycolor().red, service: "Cancel Call"),
                      ],
                    )
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}


// //Stream to get all appointments from today
// DateTime now = DateTime.now();
// DateTime today = DateTime(now.year, now.month, now.day);

// final Stream<QuerySnapshot> getAppointments = apptCollection
//     .orderBy('time')
//     .where('time', isGreaterThanOrEqualTo: Timestamp.fromDate(today))
//     .snapshots();

