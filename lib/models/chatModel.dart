class ChatModel {
  late String senderId;
  late String reciverId;
  late String message;
  late String dateTime;
   String? imageUrl;
  ChatModel({
    required this.senderId,
    required this.reciverId,
    required this.message,
    required this.dateTime,
    this.imageUrl
  });
  ChatModel.fromJason(Map<String, dynamic>? jason) {
    reciverId = jason!['reciverId'];
    senderId = jason!['senderId'];
    message = jason!['message'];
    dateTime = jason!['dateTime'];
    imageUrl = jason!['imageUrl'];

  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'reciverId': reciverId,
      'senderId': senderId,
      'dateTime': dateTime,
      'imageUrl':imageUrl
    };
  }
}
