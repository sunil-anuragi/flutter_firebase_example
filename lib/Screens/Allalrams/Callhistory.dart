import '../../Model/Emergencymodel.dart';
import '../../config/import.dart';
import '../Controller/emegencycontroller.dart';
import 'Component/callcards.dart';
import 'Component/coloridentifier.dart';

class CallHistory extends StatefulWidget {
  const CallHistory({super.key});

  @override
  State<CallHistory> createState() => _CallHistoryState();
}

class _CallHistoryState extends State<CallHistory> {
  Emergencyctrl emergencyctrl = Get.put(Emergencyctrl());
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
                  Icons.history,
                  color: Mycolor().red,
                ))).paddingOnly(right: 10),
            Text(Strings.alarmhistory),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder(
            stream: emergencyctrl.callbyid(),
            builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.data!.docs.isEmpty) {
                return const SizedBox(
                  height: 300.0,
                  child: Center(child: Text(Strings.youdonothaveanycalls)),
                );
              }

              if (snapshot.hasData) {
                List<Emergencymodel> emglist = [];

                for (var doc in snapshot.data!.docs) {
                  final appt = Emergencymodel.fromJson(
                      doc.data() as Map<String, dynamic>);

                  emglist.add(appt);
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: emglist.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () =>
                            emergencyctrl.updatecalls(emglist[index].id, 1),
                        child: Callcards(
                          emglist[index],
                          edit: false,
                        ));
                  },
                );
              }

              return const SizedBox();
            }),
          ),
          
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ColorIdentifier(color: Mycolor().Gray, service: "Actice Call"),
                ColorIdentifier(color: Mycolor().green, service: "Accepted Call"),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ColorIdentifier(color: Mycolor().red, service: "Cancel Call"),
                ],
              ),
            ],
          )

        ],
      ).paddingSymmetric(horizontal: 15, vertical: 15),
    );
  }
}
