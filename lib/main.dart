import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';
import 'package:social_chat_app/modules/Screens/Authentication/RegisterScreen.dart';

import 'Network/Local/CacheHelper.dart';
import 'components/Theme.dart';
import 'components/constants.dart';
import 'layout/LayoutScreen.dart';
import 'modules/Screens/Authentication/SocialLoginScreen.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  late Widget widget;
var token = await FirebaseMessaging.instance.getToken();
print(token);
FirebaseMessaging.onMessage.listen((event) {print(event.data.toString()); });
FirebaseMessaging.onMessageOpenedApp.listen((event) { print(event.data.toString()); });
FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await CacheHelper.init();

  uId = CacheHelper.getData(key: 'uId');
  if (uId == null) {
    widget = SocialLoginScreen();
  } else {
    widget = LayoutScreen();
  }

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  late Widget Startwidget;
  MyApp(this.Startwidget);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()


     ,
      
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: light_theme,
            home: this.Startwidget,

            ///////////////////////// dark mode ///////////////////////////
            darkTheme: dark_theme,
            themeMode: ThemeMode.light,
          );
        },
      ),
    );
  }
}
