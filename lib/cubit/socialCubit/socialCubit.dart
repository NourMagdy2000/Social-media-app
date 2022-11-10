import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_chat_app/Network/Local/CacheHelper.dart';
import 'package:social_chat_app/components/constants.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';
import 'package:social_chat_app/models/chatModel.dart';
import 'package:social_chat_app/models/commentModel.dart';
import 'package:social_chat_app/models/postModel.dart';
import 'package:social_chat_app/models/userModel.dart';
import 'package:social_chat_app/modules/Screens/SocialScreens/feeds.dart';
import 'package:social_chat_app/modules/Screens/SocialScreens/newPostScreen.dart';
import 'package:social_chat_app/modules/Screens/SocialScreens/settings.dart';
import 'package:social_chat_app/modules/Screens/SocialScreens/users.dart';
import 'package:http/http.dart' as http;

import '../../modules/Screens/SocialScreens/chat.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialIntialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? model;
  int n = 0;
  int currentIndex = 0;
  List<Widget> screens = [
    NewsFeedsScreen(),
    ChatScreen(),
NewPostScreen(),
    SettingsScreen()
  ];
  List<String> titles = ['News feeds', 'Chats','Create post' ,'Settings'];
  void getUser() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'uId'))
        .get()
        .then((value) {
      print(value.data().toString());
      model = UserModel.fromJason(value.data());

      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
      print(error.toString());
    });
  }

  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
      currentIndex=index;
      n=index;
    }
    else if(index==2){emit(SocialAddPostState());}
 else {

        currentIndex = index;
        n = index;
    }
 emit(SocialChangeBottomNavState());
  }

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image !');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('no image !');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  String profileImageUrl = '';
  void uploadProfile() {
    emit(SocialUploadProfileImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(SocialUploadProfileImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
        print(error);
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
      print(error);
    });
  }

  String coverImageUrl = '';
  void uploadCover() {
    emit(SocialUploadCoverImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        emit(SocialUploadCoverImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
        print(error);
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
      print(error);
    });
  }

  void updateUser(
      {required String name,
      required String bio,
      required String phone,
      required BuildContext context}) {
    emit(SocialUserUpdateLoadingState());

    UserModel userModel = UserModel(
        name: name,
        phone: phone,
        image: profileImage != null ? profileImageUrl : model!.image,
        bio: bio,
        cover: coverImage != null ? coverImageUrl : model!.cover,
        isEmailVerfied: model!.isEmailVerfied,
        email: model!.email,
        userId: model!.userId);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.userId)
        .update(userModel.toMap())
        .then((value) {
      profileImage = null;
      coverImage = null;
      getUser();

      Navigator.pop(context);
    }).catchError((error) {
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('no image !');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage(
      {required String text,
      required String dateTime,
      required BuildContext context}) {
    emit(SocialUploadPostImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewPost(
            text: text, dateTime: dateTime, postImage: value, context: context);
        postImage = null;
        emit(SocialUploadPostImageSuccessState());


      }).catchError((error) {
        emit(SocialUploadPostImageErrorState());
        print(error);
      });
    }).catchError((error) {
      emit(SocialUploadPostImageErrorState());
      print(error);
    });
  }

  void createNewPost(
      {required BuildContext context,
      String? postImage,
      required String dateTime,
      required String text}) {
    emit(SocialAddPostLoadingState());

    PostModel postModel = PostModel(
        name: model!.name,
        image: model!.image,
        dateTime: dateTime,
        postImage: postImage ?? '',
        text: text,
        userId: model!.userId);

    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
       postNotification();
    getPosts();
      Navigator.pop(context);
       emit(SocialAddPostSuccessState());
        }).catchError((error) {
      emit(SocialAddPostErrorState());
    });
  }

  void cancelPostImage() {
    postImage = null;
    emit(SocialCancelPostImageState());
  }

  List<PostModel> posts = [];
  List<String> postIds = [];
  List<int> likesNumber = [];
  List<int> commentsNumber = [];
  List<CommentModel> comments = [];
  void getPosts() {

    posts = [];
    likesNumber=[];
    postIds=[];
    emit(SocialGetPostLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {

      value.docs.forEach((element) {

        postIds.add(element.id);
        posts.add(PostModel.fromJason(element.data()));
        /////////////get likes number ///////////
        element.reference.collection('likes').get().then((value) {


            likesNumber.add(value.docs.length);
            print(value.docs.length);

        }).catchError((error) {print(error.toString()+' likes number');});

        ////////get comment number/////////
        element.reference.collection('comments').get().then((value) {

            commentsNumber.add(value.docs.length);

        }).catchError((error) {print(error.toString()+' likes number');});
      });
      print(likesNumber);
      print(commentsNumber);
      emit(SocialGetPostSuccessState());
    }).catchError((error) {
      print(error.runtimeType.toString()+'run time');
      emit(SocialGetPostErrorState());
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(model!.userId)
        .set({'like': true})
        .then((value) {})
        .catchError((error) {});

  }
  void commentPost({
    required String postId,
    required String comment,
  }) {
    emit(SocialMakeCommentLoadingState());

    CommentModel commentModel = CommentModel(
        writerImage: model!.image,
        writerName: model!.name,
        comment: comment,
        dateTime: DateTime.now().toString());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(model!.userId)
        .set(commentModel.toMap())
        .then((value) {
      emit(SocialMakeCommentSuccessState());
    }).catchError((error) {
      emit(SocialMakeCommentErrorState());
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    emit(SocialGetAllUsersLoadingState());
    if (users.length == 0) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['userId'] != model!.userId)
            users.add(UserModel.fromJason(element.data()));
        });

        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error.runtimeType.toString());
        emit(SocialGetAllUsersErrorState());
      });
    }
  }

  void sendMessages(
      {required String reciverId,
      required String message,
      required String dateTime}) {
    ChatModel chatModel = ChatModel(
        senderId: model!.userId,
        reciverId: reciverId,
        message: message,
        dateTime: dateTime,
        imageUrl: messageImageUrl);
//////////////////////////////////set chat in my chat reader///////////////////////////
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.userId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      messageImageUrl = '';
      messageImage = null;
      isLocked = false;
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

/////////////////////set message in other chat///////////////
    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverId)
        .collection('chats')
        .doc(model!.userId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<ChatModel> chats = [];
  void reciveMessages({required String reciverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.userId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      chats = [];
      event.docs.forEach((element) {
        chats.add(ChatModel.fromJason(element.data()));
      });
      emit(SocialGetMessagesSuccessState());
    });
  }

  TextEditingController messageController = TextEditingController();

  void getComments(String postId) {
    comments = [];
    emit(SocialGetCommentsLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .get()
        .then((value) {
      value.docs.forEach((element) {

        comments.add(CommentModel.fromJason(element.data()));


        emit(SocialGetCommentsSuccessState());
      });
      emit(SocialGetCommentsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetCommentsErrorState());
    });
  }

  File? messageImage;

  Future<void> getMessageImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      messageImage = File(pickedFile.path);

      isLocked = true;
      emit(SocialMessageImagePickedSuccessState());
    } else {
      print('no image !');
      emit(SocialMessageImagePickedErrorState());
    }
  }

  String messageImageUrl = '';
  void uploadMessageImage() {
    emit(SocialUploadMessageImageLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(messageImage!.path).pathSegments.last}')
        .putFile(messageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        messageImageUrl = value;
        messageImage = null;
        emit(SocialUploadMessageImageSuccessState());
        print(value);
      }).catchError((error) {
        emit(SocialUploadMessageImageErrorState());
        print(error);
      });
    }).catchError((error) {
      emit(SocialUploadMessageImageErrorState());
      print(error);
    });
  }

  void cancelMessageImage() {
    messageImage = null;
    isLocked = false;
    emit(SocialCancelMessageImageState());
  }

  bool isLocked = false;
  final endpoint = "https://fcm.googleapis.com/fcm/send";

  final header = {
    'Authorization':
        'AAAAXjUVmXg:APA91bHSUBNkhSIkaMvkxQeDjkZvY1wOBQqR9v078q_Ln57r6HWBivdUpB6rwxOEHxEKY_590GIZ7b84VoXwVLfMrycDRwp1KkmBcFYsec1H9O1nZUz08zXe4pvVdHrA1oY9hAKal2dS',
    'Content-Type': 'application/json'
  };
  Future<void> postNotification() async {
    await http
        .post(Uri.parse(endpoint), headers: header, body: {
          "to": "/topics/posts", // topic name
          "notification": {
            "body": "",
            "title": "new post from ${model!.name}",
            "sound": "default",
            "android": {
              "priority": "HIGH",
              "notification": {"notification_priority": "PRIORITY_MAX"}
            },
            "data": {
              "type": "order",
              "id": "87",
              "click_action": "FLUTTER_NOTIFICATION_CLICK"
            }
          }
        })
        .then((value) {})
        .catchError((error) {});
  }


}
