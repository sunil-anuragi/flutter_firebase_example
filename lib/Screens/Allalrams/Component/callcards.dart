import '../../../Model/Emergencymodel.dart';
import '../../../config/import.dart';

class Callcards extends StatelessWidget {
  final Emergencymodel emg;
  final ontapcheck;
  final ontapcancel;
  final edit;
  const Callcards(this.emg, {super.key, this.ontapcheck, this.ontapcancel, this.edit=true});

  @override
  Widget build(BuildContext context) {
    var cardColor;

    switch (emg.attendstatus) {
      case 0:
        cardColor = Mycolor().Gray;
        break;
      case 1:
        cardColor = Mycolor().green;
        break;
      case 2:
        cardColor = Mycolor().red;
        break;
    }

    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(bottom: 10.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            color: cardColor,
            width: 5.0,
          ),
          Expanded(
            child: Card(
              elevation: 5.0,
              margin: EdgeInsets.zero,
              child: Padding(
                padding:
                     EdgeInsets.only(right: 10.0, top: 10.0, left: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Strings.roomno +" : " + emg.roomno.toString(),
                                  overflow: TextOverflow.ellipsis),
                              Text(Strings.des +": " + emg.emgdes.toString(),
                                  overflow: TextOverflow.ellipsis),
                            ]),
                       
                        // )
                      ],
                    ),
                    if(edit)
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              ontapcheck();
                            },
                            child: Icon(Icons.check_circle,color: Mycolor().green,)).paddingOnly(right: 10),
                        GestureDetector(
                            onTap: () {
                              ontapcancel();
                            },
                            child: Icon(Icons.cancel,color: Mycolor().red,)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
