import 'package:pink_winky_chat/Models/Messages.dart';
import 'FireBaseNetWorking.dart';

class MessagesServices {
  void sendMessage(Messages message) {
    String senderPath = message.senderMessagePath();
    String receiverPath = message.receiverMessagePath();

    var map = message.toJson();
    //Sender
    FireBaseNetWorking _instance =
        FireBaseNetWorking(rootCollection: senderPath);
    _instance.addDocument(null, map);

    //receiver
    _instance = FireBaseNetWorking(rootCollection: receiverPath);
    _instance.addDocument(null, map);
  }
}
