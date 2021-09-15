import 'package:firebase_auth/firebase_auth.dart';

import 'package:pink_winky_chat/Services/FireBaseNetWorking.dart';
import 'package:pink_winky_chat/utilities/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  FirebaseAuth user = FirebaseAuth.instance;
  var usersRootCollection = '/users/4ZyxacwEmInl4sfQJlcL/info';
  var instance = FireBaseNetWorking();

  /// This method will create a document with the user phone Number
  void addUser() async {
    var phoneNumber = user.currentUser.phoneNumber;
    final userData = {
      'Name': 'unknown',
      'Number': phoneNumber,
      'Email': 'test@example.org',
      'DialCode': '$kCountryCode',
      'RawNumber': '$kPhoneNum',
    };
    instance.addDocument(phoneNumber, userData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('DialCode', '$kCountryCode');
    await prefs.setString('RawNumber', '$kPhoneNum');
  }

  ///For Deleting User
  void deleteUser() {}

  ///For Changing User Number
  void changeNum(int newNum) {}
}
