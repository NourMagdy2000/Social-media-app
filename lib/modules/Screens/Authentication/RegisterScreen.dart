import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/components/components.dart';
import 'package:social_chat_app/cubit/RegisterCubit/Register%20states.dart';
import 'package:social_chat_app/cubit/RegisterCubit/RegisterCubit.dart';
import 'package:social_chat_app/layout/LayoutScreen.dart';

class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        builder: (context, states) {
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
                      Text('Register',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.deepOrange,fontWeight: FontWeight.bold)),
                      Text(
                        'And enjoy !',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.lightGreen),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        type: TextInputType.name,
                        c: RegisterCubit.get(context).name2Controller,
                        labeltext: 'Name',
                        prefixicon: Icon(Icons.person),
                        validate: (String value) {
                          if (value.isEmpty) {
                            return ' this field cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        type: TextInputType.emailAddress,
                        c: RegisterCubit.get(context).username2Controller,
                        labeltext: 'Email',
                        prefixicon: Icon(Icons.email),
                        validate: (String value) {
                          if (value.isEmpty) {
                            return ' this field cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                          c: RegisterCubit.get(context).password2Controller,
                          suffix: RegisterCubit.get(context).icon,
                          obscure: RegisterCubit.get(context).isPassword2,
                          obscureText: "*",
                          suffixOnpressed: () {
                            RegisterCubit
                                .get(context)
                                .changePasswordVisibility2();
                          },
                          labeltext: 'password',
                          validate: (String value) {
                            if (value.isEmpty) {
                              return ' this field cannot be empty';
                            }
                          },
                          type: TextInputType.visiblePassword,
                          prefixicon: Icon(Icons.lock)),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        type: TextInputType.phone,
                        c: RegisterCubit.get(context).phone2Controller,
                        labeltext: 'phone',
                        prefixicon: Icon(Icons.phone),
                        validate: (String value) {
                          if (value.isEmpty) {
                            return ' this field cannot be empty';
                          }
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ConditionalBuilder(
                        condition: states is! SocialRegisterLoadingState,
                        builder: (context) => buttom(
                            text: 'REGISTER',
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                    name: RegisterCubit
                                        .get(context)
                                        .name2Controller
                                        .text,
                                    phone: RegisterCubit
                                        .get(context)
                                        .phone2Controller
                                        .text,
                                    email: RegisterCubit
                                        .get(context)
                                        .username2Controller
                                        .text,
                                    password: RegisterCubit
                                        .get(context)
                                        .password2Controller
                                        .text,);

                              } else {}  }),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, states) {
          if (states is SocialCreateUserSuccessState) {

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) =>LayoutScreen()),
                    (route) => true);
          }
        },
      ),
    );
  }}