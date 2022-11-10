class PostModel {
  late String userId;
  late String name;

  late String image;
  late String text;
  late String dateTime;
 late String postImage;
  PostModel(
      {required this.userId,
      required this.name,
      required this.image,
      required this.text,
      required this.dateTime,
      required this.postImage,
  });
  PostModel.fromJason(Map<String, dynamic>? jason) {
    userId = jason!['userId'];

    name = jason!['name'];
    image = jason!['image'];
    text = jason!['text'];
    dateTime = jason!['dateTime'];
    postImage = jason!['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'userId': userId,
      'text': text,
      'dateTime': dateTime,
      'postImage':postImage,
      'image' :image
    };
  }
}
