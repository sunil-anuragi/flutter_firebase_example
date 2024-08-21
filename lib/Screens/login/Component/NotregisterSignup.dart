import '../../../config/import.dart';

class NotRegisterSignup extends StatelessWidget {
  const NotRegisterSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(Strings.dontHaveAccount),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
            child: const Text(
              Strings.signup,
              style: TextStyle(color: Colors.purple),
            ))
      ],
    );
  }
}
