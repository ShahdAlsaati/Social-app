import 'package:bloc/bloc.dart';


abstract class SocialRegisterState{}

class SocialRegisterInitialState extends SocialRegisterState{
}
class SocialRegisterLoadingState extends SocialRegisterState{
}
class SocialRegisterSuccessState extends SocialRegisterState{
  // late final String uId;
  // SocialRegisterSuccessState(this.uId);
}
class SocialRegisterErrorState extends SocialRegisterState{
  final String error;
  SocialRegisterErrorState( this.error);
}

class SocialRegisterChangePasswordvisibilityState extends SocialRegisterState{
}
class SocialCreateUserSuccessState extends SocialRegisterState{

  late final String uId;
  SocialCreateUserSuccessState(this.uId);

}
class SocialCreateUserErrorState extends SocialRegisterState{
  final String error;

  SocialCreateUserErrorState( this.error);
}