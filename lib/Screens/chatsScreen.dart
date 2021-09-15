import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_winky_chat/Custom/searchbar.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pink_winky_chat/Screens/ChooseContactScreen.dart';

import 'package:pink_winky_chat/Services/PermissionsHandler.dart';
import 'package:pink_winky_chat/Services/contactsServices.dart';
import 'package:pink_winky_chat/utilities/Constants.dart';

class ChatsScreen extends StatelessWidget {
  final BottomAppBarController _bottomCon = Get.put(BottomAppBarController());
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          requestPermission(
            permission: Permission.contacts,
            onGranted: () async {
              //on Granted
              print(await ContactsServices().getMatchedUsersList());

              //TODO upload contacts map to the database and compare to see if contacts using the app exists
              Get.to(() => ChooseContactSCR());
            },
            onDenied: () {
              //on Denied
              Flushbar(
                titleText: Text('Error!'),
                messageText: Text('Please grant the permission to continue'),
                backgroundColor: Colors.blue,
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                shouldIconPulse: true,
                duration: Duration(seconds: 3),
              )..show(context);
            },
            onPermanentlyDenied: () {
              //on Permanently Denied
              Flushbar(
                titleText: Text('Error!'),
                messageText: Text('Please grant the permission from settings'),
                backgroundColor: Colors.blue,
                icon: Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                shouldIconPulse: true,
                duration: Duration(seconds: 3),
              )..show(context);
              Future.delayed(Duration(seconds: 3), () {
                openAppSettings();
              });
            },
          );
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.blue,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: GetBuilder<BottomAppBarController>(
        builder: (_) => AnimatedBottomNavigationBar(
          icons: _bottomCon.iconList,
          activeIndex: _bottomCon._bottomNavIndex,
          gapLocation: GapLocation.center,
          backgroundColor: Colors.blue,
          inactiveColor: Color(0xffe2f8fb),
          splashColor: Colors.tealAccent,
          activeColor: Colors.cyanAccent,
          iconSize: 33,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 25,
          rightCornerRadius: 25,
          onTap: (index) {
            _bottomCon.updateIndex(index);
            switch (index) {
              case 0:
                //TODO link this to home (chat's Screen)

                break;
              case 1:
                //TODO link this to search

                break;
              case 2:
                //TODO link this to starred messages

                break;
              case 3:
                //TODO link this to settings
                break;
            }
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //This is the top bar
            Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                //Top blue container
                Container(
                  height: 120,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.lightBlueAccent.shade200,
                          Colors.blue.shade900
                        ]),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: ListTile(
                    leading: Text(
                      'Messages',
                      style: kChatsTS,
                    ),
                    trailing: GestureDetector(
                      child: Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                //Search Bar
                Positioned(
                  child: SearchBar(
                    search: () {},
                  ),
                  top: 70,
                ),
              ],
            ),
            //Here goes the chats
            MessagesStreamBuilder(
              userNum: '+908888888888',
            ),
            //Here is the bottom bar
          ],
        ),
      ),
    );
  }
}

class BottomAppBarController extends GetxController {
  int _bottomNavIndex = 0;
  final List<IconData> iconList = [
    Icons.home,
    Icons.search,
    Icons.star_border,
    Icons.settings,
  ];

  void updateIndex(int data) {
    _bottomNavIndex = data;
    update();
  }
}

class MessagesStreamBuilder extends StatelessWidget {
  final String userNum;

  MessagesStreamBuilder({@required this.userNum});
  @override
  Widget build(BuildContext context) {
    var users = FirebaseFirestore.instance
        .collection('$kUsersRootCollection')
        .doc(userNum);

    return StreamBuilder<DocumentSnapshot>(
      stream: users.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Container();
      },
    );
  }
}
