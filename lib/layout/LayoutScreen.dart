import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:koukicons_jw/alarm1.dart';
import 'package:koukicons_jw/alarm2.dart';
import 'package:koukicons_jw/alarmoff.dart';
import 'package:koukicons_jw/home.dart';
import 'package:koukicons_jw/like.dart';
import 'package:koukicons_jw/liveNews.dart';
import 'package:koukicons_jw/phoneChat.dart';
import 'package:koukicons_jw/search.dart';
import 'package:koukicons_jw/search2.dart';
import 'package:koukicons_jw/searchFile.dart';
import 'package:koukicons_jw/searchPhone.dart';
import 'package:koukicons_jw/searchX.dart';
import 'package:koukicons_jw/settings.dart';
import 'package:koukicons_jw/upload.dart';
import 'package:koukicons_jw/users.dart';
import 'package:social_chat_app/Network/Local/CacheHelper.dart';
import 'package:social_chat_app/components/components.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/modules/Screens/Authentication/SocialLoginScreen.dart';
import 'package:social_chat_app/modules/Screens/SocialScreens/newPostScreen.dart';

import '../cubit/socialCubit/socialStates.dart';

class LayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (SocialCubit.get(context).model == null) {
        SocialCubit.get(context).getUser();
      }
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
          if (state is SocialAddPostState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewPostScreen()));
          }
        },
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      IconlyLight.notification,
                      size: 32,
                      color: Colors.teal,
                    )),
                IconButton(
                    onPressed: () {
                      CacheHelper.removeData(key: 'uId');

                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SocialLoginScreen()),
                          (route) => false);
                    },
                    icon: Icon(
                      IconlyLight.logout,
                      size: 28,
                      color: Colors.teal,
                    ))
              ],
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.n,
              backgroundColor: Colors.white,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper), label: 'NewsFeeds'),
                BottomNavigationBarItem(
                    icon: Icon(IconlyLight.chat), label: 'Chat'),
                BottomNavigationBarItem(
                    icon: Icon(IconlyLight.upload), label: 'Upload'),

                BottomNavigationBarItem(
                    icon: Icon(IconlyLight.setting), label: 'Settings')
              ],
            ),
            // ConditionalBuilder(
            //   condition: SocialCubit.get(context).model != null,
            //   builder: (context) {
            //     return Column(
            //       children: [
            //         if (!FirebaseAuth.instance.currentUser!.emailVerified)
            //           Container(
            //             color: Colors.amberAccent.withOpacity(.6),
            //             child: Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Row(
            //                 children: [
            //                   Icon(
            //                     Icons.warning_amber,
            //                     color: Colors.redAccent,
            //                   ),
            //                   SizedBox(
            //                     width: 15.0,
            //                   ),
            //                   Text(
            //                     'Please verfiy your email',
            //                     style: TextStyle(fontWeight: FontWeight.bold),
            //                   ),
            //                   SizedBox(
            //                     width: 80.0,
            //                   ),
            //                   buttom(
            //                       function: () {
            //                         FirebaseAuth.instance.currentUser!
            //                             .sendEmailVerification()
            //                             .then((value) {showDialog<String>(
            //                             context: context,
            //                             builder: (BuildContext context) =>AlertDialog(shape: CircleBorder(),
            //                             title: const Text('email verfication'),
            //                             content: const Text('successfully! please check your email ',style: TextStyle(color: Colors.green),),
            //                             actions: [
            //
            //
            //                               TextButton(
            //                                 onPressed: () => Navigator.pop(context, 'OK'),
            //                                 child: const Text('Done'),
            //                               ),
            //                             ],
            //
            //                         ));})
            //                             .catchError((error) {print(error.toString());
            //                               showDialog<String>(
            //                           context: context,
            //                           builder: (BuildContext context) => AlertDialog(shape: CircleBorder(),
            //                             title: const Text('email verfication'),
            //                             content: const Text('failed! please try again ',style: TextStyle(color: Colors.red),),
            //                             actions: [
            //
            //
            //                               TextButton(
            //                                 onPressed: () => Navigator.pop(context, 'OK'),
            //                                 child: const Text('Done'),
            //                               ),
            //                             ],
            //                           ),
            //                         );});
            //                       },
            //                       text: 'go verfiy !',
            //                       color: Colors.orange)
            //                 ],
            //               ),
            //             ),
            //           )
            //       ],
            //     );
            //   },
            //   fallback: (BuildContext context) {
            //     return Center(child: CircularProgressIndicator());
            //   },
            // )
          );
        },
      );
    });
  }
}
