import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';
import 'package:social_chat_app/models/userModel.dart';
import 'package:social_chat_app/modules/Screens/SocialScreens/chatDetails.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (SocialCubit.get(context).users.length != 0 ||
              state is SocialGetAllUsersSuccessState)
            return ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildChatItem(
                    context, SocialCubit.get(context).users[index]),
                separatorBuilder: (context, index) => Divider(
                      height: 4.0,
                      thickness: 2.0,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                itemCount: SocialCubit.get(context).users.length);
          else
            return Center(child: CircularProgressIndicator());
        });
  }

  buildChatItem(BuildContext context, UserModel model) => InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ChatDetails(model)));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                '${model.name}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 16),
              )
            ],
          ),
        ),
      );
}
