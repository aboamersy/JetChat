import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pink_winky_chat/utilities/Constants.dart';



/// This Widget is used in registration Screen
class NumberListTile extends StatelessWidget {
  const NumberListTile(
      {@required this.numTextController, this.icon, this.text});

  final IconData icon;
  final String text;
  final TextEditingController numTextController;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 60,
        child: CountryCodePicker(
          onChanged: (val) {
            kCountryCode = val.dialCode;
          },
          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
          initialSelection: 'TR',
          // optional. Shows only country name and flag
          showCountryOnly: false,
          // optional. Shows only country name and flag when popup is closed.
          showOnlyCountryWhenClosed: false,
          showFlagMain: false,
          // optional. aligns the flag and the Text left
          alignLeft: true,
        ),
      ),
      title: TextField(
        maxLength: 10,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: text,
          hintStyle: TextStyle(color: Colors.teal),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: numTextController,
        onChanged: (val) {
          kPhoneNum = val;
        },
        style: GoogleFonts.play(
            textStyle: TextStyle(
          color: Colors.teal,
        )),
      ),
    );
  }
}
