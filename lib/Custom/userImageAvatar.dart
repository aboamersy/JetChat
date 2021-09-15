import 'package:flutter/material.dart';

class UserImageAvatar extends StatelessWidget {
  final String imageURL;
  final double radius;
  UserImageAvatar({this.imageURL, @required this.radius});

  @override
  Widget build(BuildContext context) {
    bool x;
    imageURL == null ? x = false : x = true;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: CircleAvatar(
        backgroundImage:
            x ? NetworkImage(imageURL) : AssetImage('images/pink.png'),
        radius: radius,
      ),
    );
  }
}
