import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialautologin/data/github_signin/src/github_sign_in.dart';
import 'package:socialautologin/screens/contact_screen.dart';
import 'package:socialautologin/screens/otp_screen.dart';
import 'package:socialautologin/screens/social_login_screen.dart';
import 'package:socialautologin/utils/credentials.dart';
import 'package:twitter_login/twitter_login.dart';

class AuthenticationServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<bool> googleSignIn(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    if (await _googleSignIn.isSignedIn()) {
      _googleSignIn.signOut();
    }
    return await _googleSignIn.signIn().then((value) async {
      if (value == null) {
        return false;
      }
      final GoogleSignInAuthentication googleAuth = await value.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      try {
        await _auth.signInWithCredential(credential);
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == "account-exists-with-different-credential") {
          messenger.showSnackBar(SnackBar(content: Text(e.message!)));
        }
      } catch (e) {
        return false;
      }
      return false;
    });
  }

  Future<bool> facebookSignIn(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    return await FacebookAuth.instance
        .login(permissions: ["public_profile", "email"]).then((value) {
      return FacebookAuth.instance.getUserData().then((userData) async {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(value.accessToken!.token);
        try {
          await _auth.signInWithCredential(facebookAuthCredential);
          return true;
        } on FirebaseAuthException catch (e) {
          if (e.code == "account-exists-with-different-credential") {
            messenger.showSnackBar(SnackBar(content: Text(e.message!)));
          }
          return false;
        } catch (_) {
          return false;
        }
      });
    });
  }

  Future<bool> twitterLogIn() async {
    final twitterLogin = TwitterLogin(
      apiKey: Credentials.twitterApiKey,
      apiSecretKey: Credentials.twitterApiSecretKey,
      redirectURI: Credentials.twitterRedirectURI,
    );

    /// Forces the user to enter their credentials
    /// to ensure the correct users account is authorized.
    /// If you want to implement Twitter account switching, set [force_login] to true
    /// login(forceLogin: true);`
    final authResult = await twitterLogin.loginV2();
    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        return true;
      case TwitterLoginStatus.cancelledByUser:
      case TwitterLoginStatus.error:
      case null:
        return false;
    }
  }

  Future<void> googleLogout(BuildContext context) async {
    _googleSignIn.signOut();
  }

  Future<void> facebookLogout(BuildContext context) async {
    _auth.signOut();
  }

  Future<void> signOut(BuildContext context) async {
    /* if (_auth.currentUser != null) {
      _auth.currentUser?.delete();
    }*/
    await _auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SocialLoginScreen()),
          (route) => false);
    });
  }

  Future<bool> signInWithGitHub(BuildContext context) async {
    // Create a GitHubSignIn instance
    try{
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: "3464ad604c938f82ee74",
          clientSecret: "fd3a68d780fb71160dfd13bb09b44326c7c05220",
          redirectUrl:
          'https://socialloginapp-ab8cf.firebaseapp.com/__/auth/handler');

      // Trigger the sign-in flow
      final result = await gitHubSignIn.signIn(context);

      // Create a credential from the access token
      final githubAuthCredential = GithubAuthProvider.credential(result.token!);
      await FirebaseAuth.instance
          .signInWithCredential(githubAuthCredential);
      return true;
    }catch(e) {
      return false;
    }
  }

  Future<bool> signInWithPhoneNumber(BuildContext context, String isoCode, String phoneNumber) async {
    try{
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "[+][$isoCode][$phoneNumber]",
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance
                .signInWithCredential(credential)
                .then((value) async {
              if (value.user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  ContactScreen()),
                );
              }
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            print(e.message);
          },
          timeout: const Duration(seconds: 60),
          codeSent: (String verificationId, int? resendToken) {
        //    stringVerification.value = verificationId;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  OtpScreen(verificationId: verificationId,)),
            );
          },
          codeAutoRetrievalTimeout: (String verificationId) {
         //   stringVerification.value = verificationId;
          });
      return true;
    }catch(e) {
     return false;
    }

  }

//todo
// https://socialloginapp-ab8cf.firebaseapp.com/__/auth/handler
}
