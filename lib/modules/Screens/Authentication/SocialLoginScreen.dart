import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/Network/Local/CacheHelper.dart';
import 'package:social_chat_app/components/components.dart';
import 'package:social_chat_app/cubit/LoginCubit/LoginCubit.dart';
import 'package:social_chat_app/cubit/LoginCubit/LoginStates.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/modules/Screens/Authentication/RegisterScreen.dart';

import '../../../layout/LayoutScreen.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              SocialCubit.get(context).getUser();
              SocialCubit.get(context).getPosts();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LayoutScreen()),
                  (route) => true);
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold)),
                      Text(
                        'browse and make good chats',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        c: LoginCubit.get(context).usernameController,
                        labeltext: 'Email',
                        prefixicon: Icon(Icons.email),
                        validate: (String value) {
                          if (value=='') {
                            return ' this field cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          c:
                              LoginCubit.get(context).passwordController,
                          suffix: LoginCubit.get(context).icon,
                          obscure: LoginCubit.get(context).isPassword,
                          obscureText: "*",
                          suffixOnpressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          },
                          labeltext: 'password',
                          validate: (String value) {
                            if (value=='') {
                              return ' this field cannot be empty';
                            }
                          },
                          type: TextInputType.visiblePassword,
                          prefixicon: Icon(Icons.lock)),
                      SizedBox(
                        height: 30,
                      ),
                    if(state is ! SocialLoginLoadingState)
                      buttom(height: 40.0,width:double.infinity,
                            text: 'LOGIN',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: LoginCubit.get(context)
                                        .usernameController
                                        .text,
                                    password: LoginCubit.get(context)
                                        .passwordController
                                        .text);
                              } else {}
                            }),
                if(state is SocialLoginLoadingState)
                            Center(child: CircularProgressIndicator()),

                      Row(
                        children: [
                          Text(
                            'Dont have an account?',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          textbuttom(
                            text: ' Register now',
                            function: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                  (route) => false);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
