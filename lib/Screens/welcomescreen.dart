import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pink_winky_chat/Custom/regButton.dart';
import 'package:pink_winky_chat/Screens/Login-Register%20Screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DoubleBack(
        onFirstBackPress: (context) {
          // you can use your custom here
          try {
            Flushbar(
              title: "Hey!",
              message: "Press back again to exit",
              backgroundColor: Colors.teal,
              shouldIconPulse: true,
              icon: Icon(
                Icons.error,
                color: Colors.white,
              ),
              duration: Duration(seconds: 3),
            )..show(context);
          } catch (e) {
            print(e);
          }
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.white, Colors.lightBlueAccent]),
            ),
            child: Column(
              children: [
                //logo
                Container(
                  padding: EdgeInsets.only(top: 50),
                  child: Image(
                    image: AssetImage('images/pink.png'),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                //Lower Container
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.blueAccent.shade100,
                            Colors.tealAccent.shade400
                          ]),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.chat,
                          color: Colors.teal,
                          size: 150,
                        ),
                        Text(
                          'Welcome to +Plus Chat !',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bungee(
                              textStyle: TextStyle(
                                color: Colors.teal,
                                // foreground: Paint()
                                //   ..shader = kTextLinearGradient,
                              ),
                              fontSize: 25),
                        ),
                        DefButton(
                            onPress: () {
                              Get.off(() => RegisterScreen());
                            },
                            text: 'Get started'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
