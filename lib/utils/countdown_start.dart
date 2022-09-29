import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CountdownStart extends StatefulWidget {
  final VoidCallback? onPressed;
  final int resendToken;
  final String phoneNumber;

  CountdownStart({
    Key? key,
    this.onPressed,
    required this.resendToken,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<CountdownStart> createState() => _CountdownStartState();
}

class _CountdownStartState extends State<CountdownStart> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 30);

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setCountDown();
    });
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = const Duration(seconds: 30));
  }

  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  // Step 6

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final hours = strDigits(myDuration.inHours.remainder(24));
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Column(
      children: [
        Text(
          'Resend code in $minutes:$seconds',
          style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
            child: TextButton(
                onPressed: myDuration.inSeconds == 0
                    ? () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: widget.phoneNumber,
                            verificationCompleted: (value) {},
                            verificationFailed: (value) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              resetTimer();
                              startTimer();
                            },
                            forceResendingToken: widget.resendToken,
                            codeAutoRetrievalTimeout: (good) {});
                      }
                    : null,
                child: const Text(
                  "Resend",
                  style: TextStyle(color: Colors.black),
                ))),
      ],
    );
  }
}
