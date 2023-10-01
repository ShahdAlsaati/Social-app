import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../models/social_user_model.dart';
import 'state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context)=>BlocProvider.of(context);


 void userRegister({
   required String name,
    required String email,
    required String password,
    required String phone,
  })async {
   print("hello");
   emit(SocialRegisterLoadingState());
   await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email, password:password
   ).then((value) {
     print(value.user!.email);
     print(value.user!.uid);
     userCreate(
       email: email,
       phone: phone,
       uId: value.user!.uid,
       name: name,

     );
   }).catchError((error){
     print(error.toString());
     emit(SocialRegisterErrorState(error.toString()));
   });


  }


  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }){
    SocialUserModel model=SocialUserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      image: 'https://t4.ftcdn.net/jpg/03/66/66/03/360_F_366660387_PMWfjQ94F7gOGsuVs37eSSu3EENWza5F.jpg',
      cover: 'https://img.freepik.com/free-photo/woman-shouts-megaphone-with-copy-space_23-2148405269.jpg?w=1060',
      bio: 'Write your bio ....',
      isEmailVerified: false,

    );

   FirebaseFirestore.instance.collection('user').doc(uId).
   set(model.toMap()).
   then((value){
     emit(SocialCreateUserSuccessState(uId));

   }).catchError((error){
     print(error.toString());
     emit(SocialCreateUserErrorState(error.toString()));
    });

  }

  Future<UserCredential> signInWithGoogle({
    required String name,
    required String password,
    required String phone,
}) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().then((value){
      userCreate(
        email: value!.email,
        phone: phone,
        uId: value.id,
        name: name,
      );
    });
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  bool isPasswordShow= true;

  IconData  suffix= Icons.visibility_outlined;
  void changePPasswordVisibility(){
    isPasswordShow=!isPasswordShow;

    suffix=isPasswordShow? Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(SocialRegisterChangePasswordvisibilityState());
  }
}