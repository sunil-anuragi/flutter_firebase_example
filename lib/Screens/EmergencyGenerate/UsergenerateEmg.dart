import 'package:nursecallalram/Screens/Controller/Usercontroller.dart';

import '../../config/import.dart';

class Usergenerateemg extends StatefulWidget {
  const Usergenerateemg({super.key});
  @override
  State<Usergenerateemg> createState() => _UsergenerateemgState();
}

initializeAdminToken() async {
  // await FirebaseMessaging.instance.getToken().then((token) {
  //   apptCollection.doc("tokens").update({'admin-token': token});
  // });
}

class _UsergenerateemgState extends State<Usergenerateemg> {
  Userctrl userctrl = Get.put(Userctrl());
  Authctrl authctrl = Get.put(Authctrl());
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    initializeAdminToken();
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
              child: Center(child: Icon(Icons.call_end_outlined,color: Mycolor().red,))).paddingOnly(right: 10),
            
            Text(Strings.useremergency),
           
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Mycolor().primarycolor.withOpacity(0.6),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        Row(
                          children: [
                            Text(Strings.welcome + ", ",
                               
                                style: TextStyle(
                                    fontSize: 24.0,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.bold,
                                    color: Mycolor().blackcolor.withOpacity(0.7))),
                            Text(
                                // authctrl.user!.email.toString().split("@")[0],
                               FirebaseAuth.instance.currentUser!.email
                                .toString()
                                .split("@")[0],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w400,
                                    color: Mycolor().blackcolor.withOpacity(0.7))),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Text("Call Nurse",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Mycolor().blackcolor.withOpacity(0.7))),
                        const SizedBox(height: 20.0),
                      ]),
                ),
              ],
            ),
            SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.roomno,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ).paddingOnly(bottom: 10, left: 8),
                  TextFormField(
                    controller: userctrl.roomno,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: Strings.enterroom,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Strings.enteroomvalidation;
                      }
                      return null;
                    },
                  ).paddingOnly(bottom: 20),
                  Text(
                    Strings.emgdes,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ).paddingOnly(bottom: 10, left: 8),
                  TextFormField(
                    controller: userctrl.emgdes,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: Strings.enteremgdes,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.purple.withOpacity(0.1),
                      filled: true,
                    ),
                  ).paddingOnly(bottom: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await userctrl.addEmergency(context);
                        }
                      },
                      child: Text(
                        Strings.genemg,
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        shape: const StadiumBorder(),
                        backgroundColor: Mycolor().red,
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 20),
            ),
          ],
        ),
      ),
    );
  }
}
