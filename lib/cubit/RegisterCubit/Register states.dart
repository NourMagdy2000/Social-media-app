abstract class RegisterStates {}

class  SocialRegisterInitialState extends RegisterStates {}
class   SocialRegisterLoadingState extends RegisterStates {}
class   SocialRegisterSuccessState extends RegisterStates {


}
class   SocialRegisterErrorState extends RegisterStates {
  final String error ;
  SocialRegisterErrorState(this.error);

}
class   SocialRegisterChangePasswordIconState extends RegisterStates {}


class   SocialCreateUserSuccessState extends RegisterStates {


}
class   SocialCreateUserErrorState extends RegisterStates {
  final String error ;
  SocialCreateUserErrorState(this.error);

}