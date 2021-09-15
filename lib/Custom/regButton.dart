import 'package:flutter/material.dart';
import 'package:pink_winky_chat/utilities/Constants.dart';

class DefButton extends StatelessWidget {
  final Function onPress;
  final String text;
  DefButton({@required this.onPress, @required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 20),
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.teal.shade400,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextButton(
          onPressed: () {
            onPress();
          },
          child: Text(
            text,
            style: kUsualTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
