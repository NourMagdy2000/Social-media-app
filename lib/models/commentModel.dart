class CommentModel{
  late String writerImage;
  late String writerName;
  late String comment;
  late String dateTime;


 CommentModel({
    required this.writerImage,
    required this.writerName,
    required this.comment,
    required this.dateTime,
  });
 CommentModel.fromJason(Map<String, dynamic>? jason) {
    writerImage = jason!['writerImage'];
    writerName = jason!['writerName'];
    comment = jason!['comment'];
    dateTime = jason!['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      'writerImage': writerImage,
      'writerName': writerName,
      'comment': comment,
      'dateTime': dateTime,
    };
  }
}