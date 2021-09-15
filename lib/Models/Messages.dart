import 'package:pink_winky_chat/utilities/Constants.dart';

class Messages {
  final String message;
  final String sender;
  final String receiver;
  final date;

  Messages({this.message, this.sender, this.receiver, this.date});

  Map<String, dynamic> toJson() => {
        kSender: sender,
        kReceiver: receiver,
        kMessage: message,
        kDate: date,
      };

  String senderMessagePath() {
    return '$sender/contacts/$receiver/messages';
  }

  String receiverMessagePath() {
    return '$receiver/contacts/$sender/messages';
  }
}
