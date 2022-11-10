import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_chat_app/components/components.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {

        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: Text('CREATE POST'), actions: [
            TextButton(
                onPressed: () {
                  if (SocialCubit.get(context).postImage != null) {
                    SocialCubit.get(context).uploadPostImage(
                        context: context,
                        text: textController.text,
                        dateTime: DateTime.now().toString());
                  } else {
                    SocialCubit.get(context).createNewPost(
                        context: context,
                        dateTime: DateTime.now().toString().substring(0,15),
                        text: textController.text);
                  }

                },
                child: Text('POST'))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialAddPostLoadingState ||
                    state is SocialUploadPostImageLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialAddPostLoadingState ||
                    state is SocialUploadPostImageLoadingState)
                  SizedBox(height: 10.0),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          '${SocialCubit.get(context).model!.image}'),
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${SocialCubit.get(context).model!.name}',
                              style: TextStyle(
                                  height: 1.3, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is in your mind ..',
                        border: InputBorder.none),
                  ),
                ),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 140.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                  image: FileImage(
                                          SocialCubit.get(context).postImage!)
                                      as ImageProvider,
                                  fit: BoxFit.cover))),
                      CircleAvatar(
                          child: IconButton(
                              onPressed: () {
                                SocialCubit.get(context).cancelPostImage();
                              },
                              icon: Icon(
                                IconlyLight.closeSquare,
                                size: 20.0,
                              )))
                    ],
                  ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          children: [
                            Icon(IconlyLight.image),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Add Photo')
                          ],
                        )),
                    TextButton(
                      onPressed: () {},
                      child: Text('## Tags'),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
