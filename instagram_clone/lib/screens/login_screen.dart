import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/screens/home_screen.dart';
import 'package:instagram_clone/screens/sing_up_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/text_input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              color: primaryColor,
              height: 64,
            ),
            SizedBox(
              height: 24,
            ),
            TextInputField(
                hintText: 'Enter you email',
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress),
            SizedBox(
              height: 24,
            ),
            TextInputField(
                hintText: 'Enter you password',
                textEditingController: _passwordController,
                isPass: true,
                textInputType: TextInputType.text),
            SizedBox(
              height: 24,
            ),
            InkWell(
              onTap: () => loginUser(),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : Container(
                      child: const Text('Log in'),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          color: blueColor),
                    ),
            ),
            SizedBox(
              height: 24,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SingupScreen(),
                    ));
                  },
                  child: Container(
                    child: const Text(
                      "Sing up.",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
