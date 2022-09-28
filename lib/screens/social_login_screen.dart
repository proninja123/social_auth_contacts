import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:socialautologin/data/services/authetication_services.dart';
import 'package:socialautologin/screens/contact_screen.dart';
import 'package:socialautologin/screens/phone_auth_screen.dart';
import 'package:socialautologin/utils/colors.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: const Text("Social Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SignInButton(
                Buttons.Google,
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  if (await AuthenticationServices().googleSignIn(context)) {
                    navigator.push(MaterialPageRoute(
                        builder: (context) => const ContactScreen()));
                  }
                },
              ),
            ),
            SignInButton(
              Buttons.Facebook,
              onPressed: () async {
                if (await AuthenticationServices().facebookSignIn(context)) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactScreen()));
                }
              },
            ),
            SignInButton(
              Buttons.Twitter,
              onPressed: () async {
                if (await AuthenticationServices().twitterLogIn()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ContactScreen()));
                }
              },
            ),
            SignInButton(Buttons.GitHub, onPressed: () async {
              if (await AuthenticationServices().signInWithGitHub(context)) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactScreen()));
              }
            }),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneAuthScreen()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.07),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 2)),
                height: 40,
                width: double.infinity,
                child: const Text("CONTINUE WITH MOBILE"),
              ),
            )
            //  socialSignIn("Continue With Apple")
          ],
        ),
      ),
    );
  }

  Widget socialSignIn(String? name) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          border: Border.all(color: blackColor),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const Icon(Icons.facebook),
          const SizedBox(
            width: 20,
          ),
          Text(
            name!,
            style: const TextStyle(
                color: blackColor, fontWeight: FontWeight.bold, fontSize: 18),
          )
        ],
      ),
    );
  }
}
