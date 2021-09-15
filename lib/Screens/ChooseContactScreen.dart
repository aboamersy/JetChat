import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pink_winky_chat/Custom/ContactCard.dart';
import 'package:pink_winky_chat/Services/contactsServices.dart';
import 'package:pink_winky_chat/Models/Contacts.dart';
import 'package:pink_winky_chat/Custom/searchbar.dart';

class ChooseContactSCR extends StatelessWidget {
  final ContactsServices contactsServices = ContactsServices();
  @override
  Widget build(BuildContext context) {
    List<Contacts> contactsList = [];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
        title: Text(
          'Choose Contact',
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blue.shade900],
              stops: [0.2, 1.0],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: FutureBuilder(
            future: contactsServices.getUsersInfo(contactsList),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Text(
                    'No contacts Were Found! ,try adding some contacts');
              } else {
                return Column(
                  children: [
                    SearchBar(),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: contactsList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return ContactCard(contactsList[index].name, () {
                          contactsServices.onContactPress(
                              contactsList[index].number,
                              contactsList[index].name,
                              contactsList[index].imageURL);
                        }, contactsList[index].imageURL);
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
