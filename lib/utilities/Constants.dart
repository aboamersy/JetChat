//Paths
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//RegisterScreen
String kPhoneNum = '';
String kCountryCode = '+90';

final TextStyle kUsualTextStyle = GoogleFonts.play(
    textStyle: TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.bold,
  color: Colors.white,
));

final TextStyle kRegistrationButtonTS = GoogleFonts.play(
  textStyle: TextStyle(color: Colors.white, fontSize: 25),
);

final TextStyle kRegistrationTS = GoogleFonts.bungee(
  textStyle: TextStyle(color: Colors.teal, fontSize: 25),
);

final Shader kTextLinearGradient = LinearGradient(
  colors: <Color>[Colors.white70, Colors.lightBlueAccent.shade100],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

final LinearGradient kBlueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Colors.white, Colors.lightBlueAccent]);

final TextStyle kChatsTS = TextStyle(
    color: Color(0xffe2f8fb), fontSize: 25, fontWeight: FontWeight.bold);

///Database JSON keys
final kSender = 'sender';
final kReceiver = 'receiver';
final kMessage = 'message';
final kDate = 'date';

///Database root
final String kUsersRootCollection = '/users';

///Storage Root
final String kUsersStorageRoot = '/UsersProfilePhotos';
