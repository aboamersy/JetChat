import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Test {
  firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;
  var _auth = FirebaseAuth.instance.currentUser;

  /// Get an image using phone Number
  Future<String> getImage(String url) async {
    String phoneNum = _auth.phoneNumber;
    var imageUrl = await _storage
        .ref(url)
        .getDownloadURL()
        .onError((error, stackTrace) => 'oops')
        .then((value) => value.toString());
    return imageUrl;
    //    print(image.getDownloadURL());
  }
}
