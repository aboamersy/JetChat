import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pink_winky_chat/utilities/Constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FireBaseNetWorking {
  String rootCollection;
  firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  FireBaseNetWorking({this.rootCollection}) {
    rootCollection != null
        ? rootCollection = '$kUsersRootCollection/$rootCollection'
        : rootCollection = '$kUsersRootCollection/';
  }
  Future<QuerySnapshot> getDocs() async {
    Future<QuerySnapshot> data =
        FirebaseFirestore.instance.collection(rootCollection).get();
    return data;
  }

  void addDocument(String docName, Map collectionData) {
    final CollectionReference usersRoot =
        FirebaseFirestore.instance.collection(rootCollection);
    usersRoot
        .doc(docName)
        .set(collectionData)
        .catchError((onError) => print('Error $onError'));
  }

  CollectionReference referenceCollection() {
    return FirebaseFirestore.instance.collection(rootCollection);
  }

  String getRoot() {
    return rootCollection;
  }

  Future<String> getImage(String number) async {
    var imageUrl = await _storage
        .ref('$kUsersStorageRoot/$number.jpg')
        .getDownloadURL()
        .onError((error, stackTrace) => 'oops')
        .then((value) => value.toString());
    return imageUrl;
    //    print(image.getDownloadURL());
  }
}
