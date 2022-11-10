import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/components/components.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';
import 'package:social_chat_app/models/chatModel.dart';
import 'package:social_chat_app/models/userModel.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ChatDetails extends StatelessWidget {
  @override
  UserModel userModel;

  ChatDetails(this.userModel);

  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).reciveMessages(reciverId: userModel.userId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (SocialCubit.get(context).chats.length > 0)
              return Scaffold(
                appBar: defaultAppBar(
                    context: context,
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage('${userModel.image}'),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text('${userModel.name}')
                      ],
                    )),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).chats[index];
                              if (SocialCubit.get(context).model!.userId ==
                                  message.reciverId)
                                return buildMessageUnit(
                                    Colors.grey.shade300,
                                    10.0,
                                    0.0,
                                    AlignmentDirectional.centerStart,
                                    SocialCubit.get(context).chats[index]);
                              else
                                return buildMessageUnit(
                                    Colors.lightBlueAccent.shade200,
                                    0.0,
                                    10.0,
                                    AlignmentDirectional.centerEnd,
                                    SocialCubit.get(context).chats[index]);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 5.0,
                                ),
                            itemCount: SocialCubit.get(context).chats.length),
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Column(
                          children: [
                            if (SocialCubit.get(context).messageImageUrl!='')
                            Container(width: double.infinity,height: 100.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            SocialCubit.get(
                                                context)
                                                .messageImageUrl)))),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0),
                                    child: TextFormField(
                                      readOnly:
                                          SocialCubit.get(context).isLocked,
                                      controller: SocialCubit.get(context)
                                          .messageController,
                                      decoration: InputDecoration(
                                          hintText:
                                              'Write your message here ... ',
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context).getMessageImage();
                                    },
                                    icon: Icon(IconlyBold.image)),
                                if (SocialCubit.get(context).messageImage != null)
                                  IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .cancelMessageImage();
                                      },
                                      icon: Icon(IconlyBold.closeSquare,color: Colors.red,)),
                                if (SocialCubit.get(context).messageImage != null)
                                  IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .uploadMessageImage();
                                      },
                                      icon: Icon(IconlyBold.paperUpload)),
                                MaterialButton(
                                    height: 50.0,
                                    minWidth: 1.0,
                                    color: Colors.lightBlueAccent.withOpacity(.8),
                                    onPressed: () {
                                      SocialCubit.get(context).sendMessages(
                                          reciverId: userModel.userId,
                                          message: SocialCubit.get(context)
                                              .messageController
                                              .text,
                                          dateTime: DateTime.now().toString());
                                      SocialCubit.get(context).messageController =
                                          TextEditingController();
                                    },
                                    child: Icon(IconlyBold.send))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            else
              return Scaffold(
                  appBar: defaultAppBar(
                      context: context,
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage('${userModel.image}'),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text('${userModel.name}')
                        ],
                      )),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 180.0,
                        ),
                        Center(
                            child: Text(
                          'No Messages yet !',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        )),
                        Spacer(),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    readOnly: SocialCubit.get(context).isLocked,
                                    controller: SocialCubit.get(context)
                                        .messageController,
                                    decoration: InputDecoration(
                                        hintText:
                                            'Write your message here ... ',
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getMessageImage();
                                  },
                                  icon: Icon(IconlyBold.image)),
                              if (SocialCubit.get(context).messageImage != null)
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .cancelMessageImage();
                                    },
                                    icon: Icon(IconlyBold.closeSquare)),
                              if (SocialCubit.get(context).messageImage != null)
                                IconButton(
                                    onPressed: () {
                                      SocialCubit.get(context)
                                          .uploadMessageImage();
                                    },
                                    icon: Icon(IconlyBold.paperUpload)),
                              MaterialButton(
                                  height: 50.0,
                                  minWidth: 1.0,
                                  color: Colors.lightBlueAccent.withOpacity(.8),
                                  onPressed: () {
                                    SocialCubit.get(context).sendMessages(
                                        reciverId: userModel.userId,
                                        message: SocialCubit.get(context)
                                            .messageController
                                            .text,
                                        dateTime: DateTime.now().toString());
                                  },
                                  child: Icon(IconlyBold.send))
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
          },
        );
      },
    );
  }

  buildMessageUnit(Color color, double buttomEnd, double buttomStart,
      AlignmentDirectional alignmentDirectional, ChatModel chatModel) {
    if (chatModel.imageUrl != '' && chatModel.imageUrl != null)
      return Align(
        alignment: alignmentDirectional,
        child: Image(
            width: 200.0,
            height: 100.0,
            image: NetworkImage('${chatModel.imageUrl}')),
      );
    else
      return Align(
        alignment: alignmentDirectional,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(10.0),
                  bottomEnd: Radius.circular(buttomEnd),
                  topStart: Radius.circular(10.0),
                  bottomStart: Radius.circular(buttomStart))),
          child: Text('${chatModel.message}'),
        ),
      );
  }
}
