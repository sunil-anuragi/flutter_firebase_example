import '../../../Model/Emergencymodel.dart';
import '../../../config/import.dart';
import '../../Controller/emegencycontroller.dart';
import 'callcards.dart';

class CallListbuilder extends StatefulWidget {
  const CallListbuilder({super.key});

  @override
  State<CallListbuilder> createState() => _CallListbuilderState();
}

class _CallListbuilderState extends State<CallListbuilder> {
  Emergencyctrl emergencyctrl = Get.put(Emergencyctrl());

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: StreamBuilder(
          stream: emergencyctrl.allcalls(),
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
                final appt =
                    Emergencymodel.fromJson(doc.data() as Map<String, dynamic>);

                emglist.add(appt);
                emergencyctrl.assetsAudioPlayer.stop();
                emergencyctrl.assetsAudioPlayer.play();
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: emglist.length,
                itemBuilder: (context, index) {
                  return Callcards(
                    emglist[index],
                    ontapcancel: () {
                      emergencyctrl.assetsAudioPlayer.stop();
                      emergencyctrl.updatecalls(emglist[index].id, 2);
                    },
                    ontapcheck: () {
                      emergencyctrl.assetsAudioPlayer.stop();

                      emergencyctrl.updatecalls(emglist[index].id, 1);
                    },
                  );
                },
              );
            }

            return const SizedBox();
          }),
        ));
  }
}
