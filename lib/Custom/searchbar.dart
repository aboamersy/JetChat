import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatelessWidget {
  final Function search;
  final Function voiceSearch;
  SearchBar({this.search, this.voiceSearch});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Card(
        elevation: 25,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: ListTile(
          leading: Icon(
            Icons.search,
            color: Colors.black54,
          ),
          title: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 22,
              ),
            ),
            style: GoogleFonts.play(
                textStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
            )),
          ),
          trailing: GestureDetector(
            onTap: search,
            child: InkWell(
              onTap: voiceSearch,
              splashColor: Colors.grey,
              radius: 15,
              child: Icon(
                Icons.keyboard_voice,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
