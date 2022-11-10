import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/components/components.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';
import 'package:social_chat_app/models/userModel.dart';

class ViewingComments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar:
                defaultAppBar(context: context, title: Text('Post Comments')),
            body: ListView.separated(
                itemBuilder: (context, index) =>
                    buildCommentUnit(context, index),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10.0,
                    ),
                itemCount: SocialCubit.get(context).comments.length),
          );
        });
  }

  buildCommentUnit(BuildContext context, int index) => ListTile(
        title: Text('${SocialCubit.get(context).comments[index].writerName}'),
        subtitle: Text('${SocialCubit.get(context).comments[index].comment}'),
        leading: CircleAvatar(
            backgroundImage: NetworkImage(
                '${SocialCubit.get(context).comments[index].writerImage}')),
        isThreeLine: true,
      );
}
