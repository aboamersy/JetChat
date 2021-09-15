import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pink_winky_chat/Screens/Login-Register%20Screen.dart';
import 'package:pink_winky_chat/Screens/chatsScreen.dart';
import 'package:pink_winky_chat/Services/usermanagement.dart';
import 'package:pink_winky_chat/utilities/Constants.dart';
import 'package:pink_winky_chat/Services/authentication.dart';
import 'dart:async';

import 'package:rounded_loading_button/rounded_loading_button.dart';

class ConfirmationScreen extends StatefulWidget {
  final String num;
  final String verificationID;
  ConfirmationScreen({this.num, this.verificationID});
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController textEditingController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  String smsCode;
  var errorController;
  String currentText;

  Timer _timer;
  int _start = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void signIn() {
    // Sign the user in (or link) with the credential
    ApiAuth.signIn(
        verificationID: widget.verificationID,
        code: currentText,
        onSuccess: onSuccess,
        onFail: onFail);
  }

  //On sign-in success
  void onSuccess() {
    if (auth.currentUser != null) {
      UserManager().addUser();
      Get.off(() => ChatsScreen());
    }
  }

  void onFail() {
    textEditingController.clear();
    Flushbar(
      title: 'Error!',
      message: 'incorrect verification code!',
      icon: Icon(
        Icons.error,
        color: Colors.white,
      ),
      backgroundColor: Colors.pinkAccent,
      borderRadius: 25,
      duration: Duration(seconds: 5),
    )..show(context);
  }

  //On button press
  void doSomething() {
    Get.off(() => RegisterScreen());
  }

  void doNothing() {}

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.white, Colors.lightBlueAccent]),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: Icon(
                  Icons.settings_cell,
                  color: Colors.teal,
                  size: 125,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Please enter confirmation code',
                style: kRegistrationTS,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                child: PinCodeTextField(
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveColor: Colors.teal,
                      selectedFillColor: Colors.teal,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  onCompleted: (v) async {
                    setState(() {
                      _btnController.start();
                    });

                    signIn();
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                  appContext: context,
                ),
              ),
              RoundedLoadingButton(
                child: Text(
                  _start == 0 ? 'Resend code' : _start.toString(),
                  style: kRegistrationButtonTS,
                ),
                controller: _btnController,
                onPressed: _start == 0 ? doSomething : doNothing,
                color: Colors.teal,
                disabledColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
      // color: Colors.pink,
      // child: LoadingOverlay(
      //   isLoading: _loadingState,
      //   color: Colors.pink,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: [
      //       Text(
      //         'Waiting For Verification Code',
      //         style: kUsualTextStyle,
      //       ),
      //       PinCodeTextField(
      //         length: 6,
      //         obscureText: false,
      //         animationType: AnimationType.fade,
      //         pinTheme: PinTheme(
      //             shape: PinCodeFieldShape.box,
      //             borderRadius: BorderRadius.circular(5),
      //             fieldHeight: 50,
      //             fieldWidth: 40,
      //             activeFillColor: Colors.white,
      //             inactiveFillColor: Colors.white),
      //         animationDuration: Duration(milliseconds: 300),
      //         backgroundColor: Colors.pink,
      //         enableActiveFill: true,
      //         errorAnimationController: errorController,
      //         controller: textEditingController,
      //         onCompleted: (v) async {
      //           signIn();
      //         },
      //         onChanged: (value) {
      //           print(value);
      //           setState(() {
      //             currentText = value;
      //           });
      //         },
      //         beforeTextPaste: (text) {
      //           print("Allowing to paste $text");
      //           //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
      //           //but you can show anything you want here, like your pop up saying wrong paste format or etc
      //           return true;
      //         },
      //         appContext: context,
      //       ),
      //       DefButton(
      //           onPress: _start == 0 ? doSomething : null,
      //           text: _start.toString()),
      //     ],
      //   ),
      // ),
    );
  }
}
