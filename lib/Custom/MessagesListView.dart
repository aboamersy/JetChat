import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pink_winky_chat/Models/Messages.dart';
import 'package:pink_winky_chat/Custom/messageBody.dart';
import 'package:pink_winky_chat/Services/FireBaseNetWorking.dart';
import 'package:pink_winky_chat/utilities/Constants.dart';

class MessagesListView extends StatelessWidget {
  final userNum;
  final targetNum;
  final url;
  MessagesListView(
      {@required this.userNum, @required this.targetNum, @required this.url});
  @override
  Widget build(BuildContext context) {
    return MessagesStreamBuilder(
      userNum: userNum,
      targetNum: targetNum,
      url: url,
    );
  }
}

class MessagesStreamBuilder extends StatelessWidget {
  final String userNum;
  final String targetNum;
  final String url;
  MessagesStreamBuilder(
      {@required this.userNum, @required this.targetNum, @required this.url});
  @override
  Widget build(BuildContext context) {
    String path =
        Messages(sender: userNum, receiver: targetNum).senderMessagePath();
    var users = FireBaseNetWorking(rootCollection: path).referenceCollection();
    return StreamBuilder<QuerySnapshot>(
      stream: users.orderBy('date', descending: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        var count = snapshot.data.docs.length;
        return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: count,
            reverse: true,
            itemBuilder: (context, index) {
              var s = snapshot.data.docs[(count - 1) - index];
              var _sender = s.data()[kSender];
              var _receiver = s.data() [kReceiver];
              var _message =s.data() [kMessage];
              var _date =s.data()[kDate];
              var messageData = Messages(
                sender: _sender,
                receiver: _receiver,
                message: _message,
                date: _date,
              );
              print(messageData.message);
              return MessageBody(
                message: messageData.message,
                isSender: messageData.sender == userNum ? true : false,
                imageURL: url,
              );
            });
      },
    );
  }
}
