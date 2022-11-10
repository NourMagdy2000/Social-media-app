abstract class SocialStates {}

class SocialIntialState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialGetUserLoadingState extends SocialStates {}
class SocialChangeBottomNavState extends SocialStates{}

class SocialAddPostState extends SocialStates{}
class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageLoadingState extends SocialStates{}
class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadCoverImageLoadingState extends SocialStates{}
class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}
class SocialUserUpdateLoadingState extends SocialStates{}

///////////////////post states//////////////
class SocialAddPostErrorState extends SocialStates{}
class SocialAddPostLoadingState extends SocialStates{}
class SocialAddPostSuccessState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}

class SocialUploadPostImageLoadingState extends SocialStates{}
class SocialUploadPostImageSuccessState extends SocialStates{}
class SocialUploadPostImageErrorState extends SocialStates{}

class SocialCancelPostImageState extends SocialStates{}


class SocialGetPostLoadingState extends SocialStates{}
class SocialGetPostSuccessState extends SocialStates{}
class SocialGetPostErrorState extends SocialStates{}

class SocialLikePostSuccessState extends SocialStates{}
class SocialLikePostErrorState extends SocialStates{}

/////////////////comment states/////////////////////

class SocialMakeCommentLoadingState extends SocialStates{}
class SocialMakeCommentSuccessState extends SocialStates{}
class SocialMakeCommentErrorState extends SocialStates{}

/////////////////get all users//////////////////////

class SocialGetAllUsersLoadingState extends SocialStates{}
class SocialGetAllUsersSuccessState extends SocialStates{}
class SocialGetAllUsersErrorState extends SocialStates{}

/////////////////chat states///////////////////////////
class SocialGetMessagesSuccessState extends SocialStates{}
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}

//////////get comments states /////////////////

class SocialGetCommentsSuccessState extends SocialStates{}
class SocialGetCommentsLoadingState extends SocialStates{}
class SocialGetCommentsErrorState extends SocialStates{}


////////////////// picking message image states///////////////////////////

class SocialMessageImagePickedSuccessState extends SocialStates{}
class SocialMessageImagePickedErrorState extends SocialStates{}

////////////////////////upload message image states ///////////////////

class SocialUploadMessageImageSuccessState extends SocialStates{}
class SocialUploadMessageImageLoadingState extends SocialStates{}
class SocialUploadMessageImageErrorState extends SocialStates{}


/////////////// cancel message image state ///////////////
 class SocialCancelMessageImageState extends SocialStates{}

