import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class ApiAuth {
  static void register(
      {@required String phoneNumber,
      Function onCodeSent,
      Function onVerificationFailed,
      onAutoVerificationComplete}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);

        onAutoVerificationComplete();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          onVerificationFailed();
        }
      },
      codeSent: (String verificationId, int resendToken) async {
        onCodeSent(verificationId, phoneNumber);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static void signIn(
      {String verificationID,
      String code,
      Function onSuccess,
      Function onFail}) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
      verificationId: verificationID,
      smsCode: code,
    );
    try {
      await _auth.signInWithCredential(phoneAuthCredential);
      onSuccess();
    } catch (e) {
      onFail();
    }
  }
}
