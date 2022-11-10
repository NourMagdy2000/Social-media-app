import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/components/components.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';

class CommentPublishing extends StatelessWidget {
  var commentController = TextEditingController();
  String postId;
  CommentPublishing({required this.postId});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title:Text('Make a Comment') ,
              actions: [
                TextButton(
                    onPressed: () {
                      SocialCubit.get(context)
                          .commentPost( postId: postId, comment: commentController.text);
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        'Publish now',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))
              ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialMakeCommentLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialMakeCommentLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Expanded(
                  child: TextFormField(
                    controller: commentController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Write a Comment ... '),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
