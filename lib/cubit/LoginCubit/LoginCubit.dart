import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_chat_app/cubit/LoginCubit/LoginStates.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(SocialLoginInitialState());
  IconData icon=Icons.visibility;
  bool isPassword=true;

  static LoginCubit get(context) => BlocProvider.of(context);
  var usernameController = TextEditingController();

  var passwordController = TextEditingController();



  void userLogin({required String email, required String password}) async {
    emit(SocialLoginLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      emit(SocialLoginSuccessState(uId:value.user!.uid));
      print(value.user!.email.toString());
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void changePasswordVisibility(){
    isPassword=!isPassword;
    isPassword?icon=icon=Icons.visibility_off:icon=Icons.visibility;
    emit(SocialLoginChangePasswordIconState());
  }

}
