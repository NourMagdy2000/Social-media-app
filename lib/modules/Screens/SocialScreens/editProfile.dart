import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_chat_app/components/components.dart';
import 'package:social_chat_app/cubit/socialCubit/socialStates.dart';
import '../../../cubit/socialCubit/socialCubit.dart';

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          var model = SocialCubit.get(context).model;
          var nameController = TextEditingController();
          var bioController = TextEditingController();
          File? profileImage = SocialCubit.get(context).profileImage;
          File? coverImage = SocialCubit.get(context).coverImage;

          nameController.text = model!.name.toString();
          bioController.text = model!.bio.toString();
          phoneController.text = model!.phone.toString();

          return Scaffold(
            appBar: defaultAppBar(
                context: context,
                title: Text('EDIT PROFILE'),
                actions: [
                  TextButton(
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          context: context,
                          name: nameController.text,
                          bio: bioController.text,
                          phone: phoneController.text);
                    },
                    child: Text('UPDATE'),
                  ),
                  SizedBox(
                    width: 5.0,
                  )
                ]),
            body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(children: [
                    if (state is SocialUserUpdateLoadingState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 180,
                      child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                      width: double.infinity,
                                      height: 140.0,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0)),
                                          image: DecorationImage(
                                              image: coverImage == null
                                                  ? NetworkImage(model!.cover)
                                                  : FileImage(coverImage)
                                                      as ImageProvider,
                                              fit: BoxFit.cover))),
                                  CircleAvatar(
                                      child: IconButton(
                                          onPressed: () {
                                            SocialCubit.get(context)
                                                .getCoverImage();
                                          },
                                          icon: Icon(
                                            IconlyLight.camera,
                                            size: 20.0,
                                          )))
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: 64,
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage(model.image)
                                        : FileImage(profileImage)
                                            as ImageProvider,
                                  ),
                                ),
                                CircleAvatar(
                                    child: IconButton(
                                  onPressed: () {
                                    SocialCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(
                                    IconlyLight.camera,
                                    size: 20.0,
                                  ),
                                ))
                              ],
                            )
                          ]),
                    ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      SizedBox(
                        height: 10,
                      ),
                    if (SocialCubit.get(context).profileImage != null ||
                        SocialCubit.get(context).coverImage != null)
                      Column(mainAxisAlignment: MainAxisAlignment.start,
                        children:[ Container(margin: EdgeInsets.only(right: 12.0),
                          child: buttom(width: double.infinity,color: Colors.blue,
                              text: 'APPLY PHOTOS CHANGES',
                              function: () {
                                if (profileImage != null) {
                                  SocialCubit.get(context).uploadProfile();
                                  print(SocialCubit.get(context).profileImageUrl);
                                }
                                if (coverImage != null) {
                                  SocialCubit.get(context).uploadCover();
                                }
                              }),
                        ),  if (state is SocialUploadProfileImageLoadingState ||
                            state is SocialUploadCoverImageLoadingState)
                          LinearProgressIndicator(),

                        ]  ),

                    SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                        c: nameController,
                        labeltext: 'Name',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name must be filled';
                          } else {
                            return null;
                          }
                        },
                        prefixicon: Icon(IconlyLight.user2)),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        c: bioController,
                        labeltext: 'Bio',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name must be filled';
                          } else {
                            return null;
                          }
                        },
                        prefixicon: Icon(IconlyLight.edit)),
                    SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        c: phoneController,
                        labeltext: 'phone',
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'name must be filled';
                          } else {
                            return null;
                          }
                        },
                        prefixicon: Icon(IconlyLight.call))
                  ])),
            ),
          );
        },
        listener: (context, state) {});
  }
}
