import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:koukicons_jw/add.dart';
import 'package:social_chat_app/cubit/socialCubit/socialCubit.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';
import 'package:social_chat_app/modules/Screens/SocialScreens/Comment.dart';
import 'package:social_chat_app/modules/Screens/SocialScreens/viewingComments.dart';
import '../../../models/postModel.dart';

class NewsFeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {

        SocialCubit.get(context).getPosts();

      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (SocialCubit.get(context).posts.length > 0 &&
              SocialCubit.get(context).model != null)
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(8.0),
                    elevation: 20,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/hands-holding-puzzle-business-problem-solving-concept_53876-129544.jpg?t=st=1656877371~exp=1656877971~hmac=84defce0b9636f5acdcb3338920e2c273785b5b9d865b5c0d3703af3ae56a2f7&w=1060'),
                            width: double.infinity,
                            height: 170,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Communicate with friends now !',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 17)),
                          )
                        ]),
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildPostItem(context,
                          SocialCubit.get(context).posts[index], index),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 5.0,
                          ),
                      itemCount: SocialCubit.get(context).posts.length)
                ],
              ),
            );
          else
            return Center(child: CircularProgressIndicator());
        },
      );
    });
  }

  Widget buildPostItem(context, PostModel postModel, int index) => Card(
        elevation: 5.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${postModel.image}'),
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
                              '${postModel.name}',
                              style: TextStyle(
                                  height: 1.3, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Icon(
                              Icons.check_circle,
                              size: 16.0,
                              color: Colors.blue,
                            )
                          ],
                        ),
                        Text(
                          '${postModel.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.3),
                        )
                      ],
                    )),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_horiz, size: 16.0),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${postModel.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 6.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#be hopeful',
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 5.0),
                      child: Container(
                        height: 20.0,
                        child: MaterialButton(
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          child: Text(
                            '#be hopeful',
                            style: TextStyle(color: Colors.lightBlue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (postModel.postImage != '')
              Container(
                  width: double.infinity,
                  height: 140.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                          image: NetworkImage('${postModel.postImage}'),
                          fit: BoxFit.cover))),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(
                                Typicons.heart,
                                size: 20,
                              ),
                            ),
                            Text(
                              '',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).getComments(SocialCubit.get(context).postIds[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewingComments()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Icon(Typicons.comment, size: 20),
                            ),
                            Text(

                                 'comments',
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 5.0, right: 10.0, bottom: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentPublishing(
                                    postId:SocialCubit.get(context).postIds[index]
                                       )));
                      },
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.0,
                            backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).model!.image}'),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Text('write a comment ...',
                              style: Theme.of(context).textTheme.caption!),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context)
                          .likePost(SocialCubit.get(context).postIds[index]);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(
                            Typicons.heart,
                            size: 20,
                          ),
                          Text(
                            ' Like',
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
}
