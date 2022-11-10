
abstract class LoginStates {}

class  SocialLoginInitialState extends LoginStates {}
class SocialLoginLoadingState extends LoginStates {}
class  SocialLoginSuccessState extends LoginStates {

final String uId;
SocialLoginSuccessState({required this.uId});



}
class  SocialLoginErrorState extends LoginStates {
  SocialLoginErrorState(String string);


}
class  SocialLoginChangePasswordIconState extends LoginStates {}
