import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

Widget defaultFormField(
    {required TextEditingController c,
      required String labeltext,
      required Function validate,
      onSubmitted,
      suffix,
      prefixicon,
      TextInputType? type,
      bool obscure = false,
      String obscureText = '*',
      suffixOnpressed}) =>
    Container(
      height: 70,
      width: 400,
      child: TextFormField(
          validator: (value) {
            return validate!(value);
          },
          obscureText: obscure,
          obscuringCharacter: obscureText,
          keyboardType: type,
          controller: c,
          onChanged: onSubmitted,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              labelText: labeltext,
              prefixIcon: prefixicon,
              suffixIcon: IconButton(
                onPressed: suffixOnpressed,
                icon: Icon(suffix),
              ))),
    );

Widget buttom(
        {String? text,
        Function? function,
        height = 40.0,
        width = 100.0,
        color = Colors.orangeAccent}) =>
    Container(
      margin: EdgeInsets.only(left: 12),
      height: height,
      width: width,
      child: FlatButton(
        child: Text(
          text ?? '',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
        ),
        onPressed: () {
          function!();
        },
        color: color,
      ),
    );
Widget textbuttom({String? text, Function? function}) => TextButton(
      child: Text(
        text ?? "",
        style: TextStyle(color: Colors.lightGreen, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        function!();
      },
    );
PreferredSizeWidget defaultAppBar(
        {required BuildContext context,
        title,
        List<Widget>? actions}) =>
    AppBar(
      titleSpacing: 5.0,
      leading: IconButton(
          icon: Icon(IconlyLight.arrowLeft2),
          onPressed: () {
            Navigator.pop(context);
          }),
      title: title,
      actions: actions,
    );

// void showToast({ required String message,colorState ?state})=> Fluttertoast.showToast(
//     msg:message,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: switchColor(state: state),
//     textColor: Colors.white,
//     fontSize: 16.0
// );
// Color switchColor({@required colorState ?state}){
//   if(state==colorState.SUCCSESS){return Colors.green;}
//   else if(state==colorState.WARNING){return Colors.orangeAccent;}
//   else return Colors.red;
//
// }
//
// enum colorState{SUCCSESS,WARNING,ERORR}

// void signOut(context)=>TextButton(
//   child: Text('signOut'),
//   onPressed: () {
//     Cache_helper.removeData(key: 'token').then((value) {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => Login_screen()),
//               (route) => true);
//     });
//   },
// );
