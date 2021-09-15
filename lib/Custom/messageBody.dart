import 'package:flutter/material.dart';
import 'package:pink_winky_chat/Custom/userImageAvatar.dart';

class MessageBody extends StatelessWidget {
  final String message;
  final bool isSender;
  final String imageURL;
  MessageBody(
      {@required this.message,
      @required this.isSender,
      @required this.imageURL});
  @override
  Widget build(BuildContext context) {
    return Container(child: _buildMainRow(isSender, message));
  }

//The main Row
  Widget _buildMainRow(bool sender, String message) => Row(
        mainAxisAlignment:
            sender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          sender
              ? Container()
              : UserImageAvatar(
                  radius: 15,
                  imageURL: imageURL,
                ),
          _buildMessageColumn(sender: sender, message: message),
          !sender
              ? Container()
              : UserImageAvatar(
                  radius: 15,
                  imageURL: imageURL,
                ),
        ],
      );

//Contain the message Container
  Widget _buildMessageColumn({bool sender, String message}) => Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            constraints: BoxConstraints(minHeight: 45, maxWidth: 180),
            padding: EdgeInsets.all(8),
            decoration: !sender
                ? BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ),
                    color: Colors.white,
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    color: Color(0xff2760E5),
                  ),
            child: Text(
              '$message',
              style: TextStyle(
                color: sender ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      );
}
