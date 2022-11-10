// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/components/constants.dart';
import 'package:social_chat_app/cubit/RegisterCubit/Register%20states.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/userModel.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(SocialRegisterInitialState());
  IconData icon = Icons.visibility;
  bool isPassword2 = true;

  static RegisterCubit get(context) => BlocProvider.of(context);
  var username2Controller = TextEditingController();

  var password2Controller = TextEditingController();
  var phone2Controller = TextEditingController();
  var name2Controller = TextEditingController();

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) async {
    emit(SocialRegisterLoadingState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userCreate(
          userId: value.user!.uid,
          email: email,
          name: name,
          phone: phone,
          isEmailVerfied: value.user!.emailVerified);
uId=value.user!.uid;
      print(value.user!.email.toString());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate(
      {required String userId,
      required String email,
      required String name,
      required String phone,
      required isEmailVerfied}) async {
    UserModel userModel = UserModel(
        userId: userId,
        name: name,
        email: email,
        phone: phone,
        isEmailVerfied: isEmailVerfied,
        image:
            'https://img.freepik.com/premium-photo/seaside-summer-beach-with-starfish-shells-coral-sandbar-blur-sea-background-concept-summertime-beach-vintage-color-tone_1484-943.jpg?w=1060',
        bio: 'write your bio...',
        cover:
            'https://img.freepik.com/free-photo/white-chairs-table-beach_1339-4293.jpg?w=1060&t=st=1657147514~exp=1657148114~hmac=0aec643f389d990f01d7d93f3321828a8c17a6cd7dbd7e9902cec2d2cf60f75a');

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userModel.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error));
    });
  }

  void changePasswordVisibility2() {
    isPassword2 = !isPassword2;
    isPassword2 ? icon = icon = Icons.visibility_off : icon = Icons.visibility;
    emit(SocialRegisterChangePasswordIconState());
  }
}
