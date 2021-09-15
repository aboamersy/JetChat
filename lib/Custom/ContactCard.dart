import 'package:flutter/material.dart';
import 'package:pink_winky_chat/Custom/userImageAvatar.dart';

class ContactCard extends StatelessWidget {
  ContactCard(this.name, this.onTap, this.url);
  final String name;
  final String url;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey,
      radius: 1000,
      child: Card(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: UserImageAvatar(
                imageURL: url,
                radius: 40,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '$name',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            Expanded(child: Text('')),
          ],
        ),
      ),
    );
  }
}
