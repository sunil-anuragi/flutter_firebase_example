import '../../../Config/Import.dart';

class loginHeader extends StatelessWidget {
  const loginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.welcomeback.toString(),
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text(
          Strings.logintxt.toString().toUpperCase(),
          style: TextStyle(fontSize: 14, letterSpacing: 5),
        ),
      ],
    );
  }
}
