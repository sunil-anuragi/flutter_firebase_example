import 'import.dart';

class Utils {
  toast({message}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Mycolor().primarycolor,
        textColor: Mycolor().whitecolor,
        fontSize: 16.0);
  }
}
