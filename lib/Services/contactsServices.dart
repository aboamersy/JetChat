import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:pink_winky_chat/Models/Contacts.dart';
import 'package:pink_winky_chat/Screens/personChatScreen.dart';
import 'package:pink_winky_chat/Services/FireBaseNetWorking.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactsServices {
  FireBaseNetWorking _instance = FireBaseNetWorking();
  String countryCode = '';
  String phoneNum = '';

  ///Get contacts information as  Iterable w
  Future<Iterable> _getContacts() async {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    return contacts;
  }

  ///Return a map with number as key and full name as value
  Future<Map<String, String>> _getContactsList() async {
    final Map<String, String> contacts = {};
    Iterable<Contact> contactsIterable = await _getContacts();

    for (var s in contactsIterable) {
      for (var x in s.phones) contacts[x.value] = s.displayName;
    }

    return contacts;
  }

  ///Get current user country code and number (for manipulating contacts)
  Future<void> _getContactSyntax() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    countryCode = prefs.getString('DialCode');
    phoneNum = prefs.getString('RawNumber');
  }

  ///Return a map of contacts (key=number,value=full name) after refactoring it.
  Future<Map<String, String>> getContacts() async {
    await _getContactSyntax();
    var contacts = await _getContactsList();
    Map<String, String> fixedContacts = {};
    contacts.forEach((key, value) {
      var number = key
          .toString()
          .replaceAll(' ', '')
          .replaceAll('(', '')
          .replaceAll(')', '')
          .replaceAll('-', '');
      var numberLength = phoneNum.length + 1;

      /// if the contact is like (0$phoneNumber)
      if (number.length == numberLength) {
        number = '$countryCode${number.substring(1)}';
        fixedContacts[number] = value;
      } else if (number.length == phoneNum.length) {
        number = '$countryCode$number';
        fixedContacts[number] = value;
      }

      /// if the contact is like (00$CountryCode$phoneNum)
      else if (number.substring(0, 2) == '00') {
        number = '+${number.substring(2)}';
        fixedContacts[number] = value;
      }

      /// if the contact is like (+$CountryCode$phoneNum)
      else if (number.substring(0, 1) == '+') {
        fixedContacts[number] = value;
      }
    });

    return fixedContacts;
  }

  Future<List<String>> getUserList() async {
    List<String> users = [];
    var usersNum = _instance.getDocs();
    await for (var s in usersNum.asStream()) {
      for (var z in s.docs) {
        users.add(z.id);
      }
    }
    return users;
  }

  Future<Map<String, String>> getMatchedUsersList() async {
    Map<String, String> matchedUsers = {};
    Map<String, String> contacts = await getContacts();
    List<String> users = await getUserList();
    contacts.forEach((key, value) {
      if (users.contains(key)) matchedUsers[key] = value;
    });
    return matchedUsers;
  }

  Future<List<Contacts>> getUsersInfo(List<Contacts> contactsList) async {
    List<String> contactsURL = [];
    int counter = 0;
    var s = await ContactsServices().getMatchedUsersList();
    for (var x in s.keys) {
      await _instance.getImage(x).then((value) => contactsURL.add(value));
    }

    s.forEach((key, value) {
      Contacts contact = Contacts(
          name: value,
          number: key,
          imageURL:
              contactsURL[counter] != null ? contactsURL[counter++] : null);
      contactsList.add(contact);
    });

    return contactsList;
  }

  void onContactPress(String number, String name, String url) {
    Get.to(
      () => PersonChatScreen(),
      arguments: [number, name, url],
    );
  }
}
