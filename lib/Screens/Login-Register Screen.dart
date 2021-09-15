import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_winky_chat/Custom/numberListTile.dart';
import 'package:pink_winky_chat/Screens/chatsScreen.dart';
import 'package:pink_winky_chat/Screens/confirmationScreen.dart';
import 'package:pink_winky_chat/Services/authentication.dart';
import 'package:pink_winky_chat/Services/usermanagement.dart';
import 'package:pink_winky_chat/utilities/Constants.dart';
import 'package:flushbar/flushbar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterScreen extends StatelessWidget {
  final _btnCont = RoundedLoadingButtonController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController numTextController = TextEditingController();

  void onCodeSent(var verificationId, var phoneNumber) {
    Get.to(
      () => ConfirmationScreen(
        verificationID: verificationId,
        num: phoneNumber,
      ),
    );
  }

  void onAutoRegisterComplete() {
    UserManager().addUser();
    Get.off(() => ChatsScreen());
  }

  void onVerificationFailed() {
    _btnCont.stop();
    Flushbar(
      shouldIconPulse: true,
      title: 'Error!',
      message: 'incorrect phone number,please check your number',
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      backgroundColor: Colors.teal,
      borderRadius: 25,
      duration: Duration(seconds: 7),
    )..show(Get.context);
  }

  void onRegPressed() {
    // Apply login-register Functionality here...
    String phoneNum = '$kCountryCode$kPhoneNum';
    print(phoneNum);

    ApiAuth.register(
      phoneNumber: phoneNum,
      onCodeSent: onCodeSent,
      onAutoVerificationComplete: onAutoRegisterComplete,
      onVerificationFailed: onVerificationFailed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: kBlueGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                child: Icon(
                  Icons.mobile_friendly,
                  size: 100,
                  color: Colors.teal,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Please enter your phone number',
                textAlign: TextAlign.center,
                style: kRegistrationTS,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Divider(
                  height: 5,
                  color: Colors.teal,
                  thickness: 3,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Card(
                  child: NumberListTile(
                    numTextController: numTextController,
                    icon: Icons.call,
                    text: 'Enter your number here',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RoundedLoadingButton(
                child: Text(
                  'Register',
                  style: kRegistrationButtonTS,
                ),
                controller: _btnCont,
                onPressed: () {
                  _btnCont.start();
                  FocusScope.of(context).unfocus();
                  onRegPressed();
                },
                color: Colors.teal,
                disabledColor: Colors.teal,
              ),
            ],
          )),
    );
  }
}
