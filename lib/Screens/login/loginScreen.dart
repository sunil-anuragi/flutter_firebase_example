import '../../config/import.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loginHeader().paddingOnly(bottom: 50),
          InputSection(),
          // Forgetpassword(),
          NotRegisterSignup(),
        ],
      ).paddingSymmetric(horizontal: 20),
    );
  }
}
