import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';

class SocialLoginCubit extends Cubit<SocialLoginState> {
  SocialLoginCubit() : super(SocialLoginInitialState());

  static SocialLoginCubit get(context)=>BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) async {
    emit(SocialLoginLoadingState());
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password:password,
    ).then((value)
    {
      print(value.user!.email);
      print(value.user!.uid);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error)
    {
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }
  bool isPasswordShow= true;

  IconData  suffix= Icons.visibility_outlined;
  void changePPasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix=isPasswordShow? Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ShopChangePasswordvisibilityState());
  }
}