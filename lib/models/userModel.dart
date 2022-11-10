class UserModel {
  late String userId;
  late String name;
  late String email;
  late String phone;
  late bool isEmailVerfied;
  late String image;
  late String bio;
late String cover;
  UserModel(
      {required this.userId,
      required this.name,
      required this.email,
      required this.phone,
      required this.isEmailVerfied,
      required this.image,
      required this.bio,required this.cover});
  UserModel.fromJason(Map<String, dynamic>? jason) {
    userId = jason!['userId'];
    email = jason!['email'];
    name = jason!['name'];
    phone = jason!['phone'];
    isEmailVerfied = jason!['isEmailVerfied'];
    image = jason!['image'];
    bio = jason!['bio'];
    cover=jason!['cover'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'userId': userId,
      'phone': phone,
      'isEmailVerfied': isEmailVerfied,
      'image':image,
      'bio':bio,
      'cover':cover
    };
  }
}
