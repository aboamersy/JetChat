import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pink_winky_chat/Custom/MessagesListView.dart';
import 'package:pink_winky_chat/Models/Messages.dart';
import 'package:pink_winky_chat/Screens/chatsScreen.dart';
import 'package:pink_winky_chat/Services/MessagesServices.dart';
import 'package:pink_winky_chat/controllers/MessagesController.dart';

List<ListTile> list = [];
Widget bottomSheet = BottomSheet(
  onClosing: () {},
  builder: (context) => Container(
    color: Colors.blue,
    child: Text('Fuck Yeah'),
  ),
);

class PersonChatScreen extends StatelessWidget {
  final userNum = FirebaseAuth.instance.currentUser.phoneNumber;
  final MessagesServices _messagesInstance = MessagesServices();
  final MessagesController _controller = MessagesController();
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    String name = data[1];
    String receiverNumber = data[0];
    String url = data[2];
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.off(() => ChatsScreen()),
            child: Icon(
              Icons.arrow_back,
              color: Color(0xff2760E5),
            ),
          ),
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 2, right: 15),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('images/ahmad.jpg'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '$name',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 140,
                  ),
                  Icon(
                    Icons.call,
                    color: Color(0xff2760E5),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Icon(
                    Icons.video_call,
                    color: Color(0xff2760E5),
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          backgroundColor: Color(0xffF7F7F7),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //the messages container
            Flexible(
              fit: FlexFit.tight,
              flex: 4,
              child: Container(
                color: Color(0xffEFEFEF),
                child: MessagesListView(
                  userNum: userNum,
                  targetNum: receiverNumber,
                  url: url,
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            //Text Field
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10, right: 15),
                                child: Card(
                                  elevation: 15,
                                  color: Color(0xffF7F7F7),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: Colors.white70, width: 1),
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  child: TextField(
                                    cursorColor: Colors.grey,
                                    controller: _controller.getController(),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 10),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: 'Write a message..',
                                      hintStyle: TextStyle(
                                        color: Color(0xffE0E1E3),
                                      ),
                                    ),
                                    style: GoogleFonts.play(
                                      textStyle: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Send Circle Avatar
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Material(
                                child: InkWell(
                                  radius: 50,
                                  borderRadius: BorderRadius.circular(25),
                                  splashColor: Colors.grey,
                                  onTap: () {
                                    //TODO send functionality here
                                    String messageText =
                                        _controller.getMessage();
                                    if (messageText != '') {
                                      final time = FieldValue.serverTimestamp();
                                      var message = Messages(
                                        sender: userNum,
                                        receiver: receiverNumber,
                                        message: messageText,
                                        date: time,
                                      );
                                      _messagesInstance.sendMessage(message);
                                      _controller.clearField();
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff2760E5),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: CircleAvatar(child: Icon(Icons.mic)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: CircleAvatar(child: Icon(Icons.photo)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: InkWell(
                              onTap: () async {},
                              child: CircleAvatar(
                                  child: Icon(Icons.photo_camera_outlined)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
