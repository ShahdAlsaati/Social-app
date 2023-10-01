import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pro1/models/message_model.dart';
import 'package:pro1/modules/chat/chat_screen.dart';
import 'package:pro1/modules/feeds/feeds_screen.dart';
import 'package:pro1/modules/new_post/new_post_screen.dart';
import 'package:pro1/modules/setting/setting_screen.dart';
import '../../models/commentModel.dart';
import '../../models/post_model.dart';
import '../../models/social_user_model.dart';
import '../../modules/search/search_screen.dart';
import '../../shared/netWork/local/cach_helper.dart';
import 'state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());


  static SocialCubit get(context) => BlocProvider.of(context);
  SocialUserModel? uModel;

  void getUserData() {
    emit(SocialGetUserLaodingState());
    FirebaseFirestore.instance.
    collection('user').
    doc(CacheHelper.getData(key: 'uId')).
    get().then((value) {
      print(value.data());
      uModel = SocialUserModel.fromJson(value.data());
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;


  List<Widget> screens = [
    feedsScreen(),
    chatScreen(),
    newPostScreen(),
    searchScreen(),
    settingScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Search',
    'Setting',
  ];

  void changBottonNavBar(int index) {
      if(index == 2){
        users=[];
        getUsers();
      }

      if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialchangeBottonNavBarState());
    }
  }

  var picker = ImagePicker();
  XFile? profileFile;

  void pickImage() {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      profileFile = value;
      print(profileFile!.path);
      emit(SocialPickProfileImageState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialPickProfileImageErrorState());
    });
  }

  XFile? coverFile;

  void pickCover() {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      coverFile = value;
      print(coverFile!.path);
      emit(SocialPickCoverImageState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialPickCoverImageErrorState());
    });
  }

  XFile? postImageFile;


  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLaodingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri
        .file(profileFile!.path)
        .pathSegments
        .last}')
        .putFile(File(profileFile!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  emit(SocialUploadProfileImageSuccesState());
        print(value);
        updateUserData(name: name,
            phone: phone,
            bio: bio,
            profile: value);
      }).catchError((error) {
        print(profileFile!.path);
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(profileFile!.path);
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLaodingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${Uri
        .file(coverFile!.path)
        .pathSegments
        .last}')
        .putFile(File(coverFile!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadProfileCoverSuccesState());
        print(value);
        updateUserData(name: name,
            phone: phone,
            bio: bio,
            cover: value);
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  // void updateUserImages({
  //   required String name,
  //   required String phone,
  //   required String bio,
  //      })
  //          {
  //            emit(SocialUserUpdateLaodingState());
  //            if(coverFile!=null){
  //              uploadCoverImage();
  //
  //            }
  //            else if(profileFile!=null){
  //              uploadProfileImage();
  //            }else if(profileFile!=null&&coverFile!=null){
  //
  //              uploadCoverImage();
  //              uploadProfileImage();
  //            }
  //            else{
  //          updateUserData(
  //            name: name,
  //            phone: phone,
  //            bio: bio,
  //          );
  //            }
  //
  // }
  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profile,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: uModel!.email,
      cover: cover ?? uModel!.cover,
      image: profile ?? uModel!.image,
      uId: uModel!.uId,
      phone: phone,
      bio: bio,
      isEmailVerified: false,);
    FirebaseFirestore.instance.
    collection('user')
        .doc(uModel!.uId)
        .update(model.toMap())
        .then((value) {

      getUserData();
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialUserUpdateErrorState());
    });
  }

  XFile? postFile;

  void pickPostImage() {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      postFile = value;
      print(postFile!.path);
      emit(SocialPickPostSuccessImageState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialPickPostImageErrorState());
    });
  }

  void removePostImage() {
    postFile = null;
    emit(SocialRemovePostImageState());
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLaodingState());

    PostModel model = PostModel(
      name: uModel!.name,
      uId: uModel!.uId,
      image: uModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
      isSaved: false,

    );
    FirebaseFirestore.instance.
    collection('post')
        .add(model.toMap())
        .then((value) {
          // postId=value.id;
      emit(SocialCreatePostSuccesState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void uploadePostImages({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLaodingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('post/${Uri
        .file(postFile!.path)
        .pathSegments
        .last}')
        .putFile(File(postFile!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }
  PostModel? postModel;
  List<PostModel> posts = [];
  List<PostModel> myPost = [];
  List<PostModel> savedPost = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance
        .collection('post')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get(

        ).then((value){

          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error){

        });

      });
      emit(SocialGetPostSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialGetPostErrorState(error.toString()));
    });
  }
  void savePost(String? postId){
    FirebaseFirestore.instance
        .collection('post')
        .doc(postId)
        .update({
      'isSaved':true,
    }).then((value){
      emit(PostSaveSuccessState());
    }).catchError((error){
      emit(PostSaveErrorState());
    });
  }
  void getSavedPosts() {
      savedPost = [];
      for(int index =0;index<posts.length;index++)
        if(posts[index].isSaved==true)
          savedPost.add(posts[index]);

  }
  int countMyPost(String? uId){
    myPost=[];
    for(int index =0;index<posts.length;index++)
    if(posts[index].uId==uId)
      myPost.add(posts[index]);

    return myPost.length;
  }

  void likePost(String postId){
   FirebaseFirestore.instance
       .collection('post')
       .doc(postId)
       .collection('likes')
       .doc(uModel!.uId)
       .set({
     'like':true,
   }).then((value){
     emit(SocialLikePostSuccessState());
   }).catchError((error){
     emit(SocialLikePostErrorState(error.toString()));
   });
  
  }

  List<CommentModel> Comment = [];
  List<int> commentsCount = [];

  void createComment({
    required String? postId,
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreateCommentLaodingState());

    CommentModel model = CommentModel(
      image: uModel!.image,
      name: uModel!.name,
      postId: postId,
      dateTime: dateTime,
      text: text,);
    FirebaseFirestore.instance.
    collection('post')
    .doc(uModel!.uId)
    .collection('comment')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreateCommentSuccesState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialCreateCommentErrorState());
    });
  }
  void getComments(String? postId) {
    FirebaseFirestore.instance
        .collection('post')
         .doc(postId)
        .collection('comment')
        .orderBy('dateTime')
        .get()
        .then((value){
          Comment=[];
          value.docs.forEach((element) {
            Comment.add(CommentModel.fromJson(element.data()));
          });
          emit(SocialGetCommentSuccesState());

    }).catchError((error){
      print(error.toString());
      emit(SocialGetCommentErrorState());

    });

  }


List<SocialUserModel> users=[];

  void getUsers()
  {
    users=[];
    FirebaseFirestore.instance
        .collection('user')
        .get()
        .then((value) {
      value.docs.forEach((element)
      {
        if(element.data()['uId']!=uModel!.uId)
        users.add(SocialUserModel.fromJson(element.data()));

      });
      emit(SocialGetAllUsersSuccessState());
    })
        .catchError((error) {
      print(error.toString());
      emit(SocialGetAllUsersErrorState(error.toString()));
    });
  }
  XFile? chatImageFile;

  void pickchatImage() {
    picker.pickImage(source: ImageSource.gallery).then((value) {
      chatImageFile = value;
      print(chatImageFile!.path);
    }).catchError((error) {
      print(error.toString());
    });
  }
  void removechatImage() {
    chatImageFile = null;
    emit(SocialRemovePostImageState());
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
    String? chatImage,

  }){
    MessageModel model=MessageModel(
      text: text,
      senderId: uModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
      chatImage: chatImage?? '',
    );
    FirebaseFirestore.instance
    .collection('user')
    .doc(uModel!.uId)
    .collection('chats')
    .doc(receiverId)
    .collection('message')
    .add(model.toMap())
    .then((value){
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialSendMessageErrorState());

    });
    FirebaseFirestore.instance
        .collection('user')
        .doc(receiverId)
        .collection('chats')
        .doc(uModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value){
      emit(SocialSendMessageSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SocialSendMessageErrorState());

    });
    
}

List<MessageModel>messages=[];
  void uploadeChatImages({
    required String receiverId,
    required String dateTime,
    required String text,
    String? chatImage,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${receiverId}/chat/${Uri
        .file(chatImageFile!.path)
        .pathSegments
        .last}')
        .putFile(File(chatImageFile!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
           receiverId: receiverId,
          dateTime: dateTime,
          text:text,
          chatImage: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialSendMessageSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState());
    });
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('user/${uModel!.uId}/chat/${Uri
        .file(chatImageFile!.path)
        .pathSegments
        .last}')
        .putFile(File(chatImageFile!.path))
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        sendMessage(
          receiverId: receiverId,
          dateTime: dateTime,
          text:text,
          chatImage: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialSendMessageSuccessState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState());
    });
  }
  void getMessages({
  required String receiverId,
}){
    FirebaseFirestore.instance
        .collection('user')
        .doc(uModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
         .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
       messages=[];

      event.docs.forEach((element)
      {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  IconData? mode;

  bool isDark=false;
  void changeMode({bool? fromShared}){

    if(fromShared!=null){
      isDark=fromShared;
      mode=isDark? Icons.light_mode_outlined:Icons.dark_mode_outlined;

      emit(SocialChangeModeState());}
    else{
      isDark=!isDark;
      mode=isDark? Icons.light_mode_outlined:Icons.dark_mode_outlined;
      CacheHelper.putBool(key:'isDark' ,value:isDark ).then((value)
      {
        emit(SocialChangeModeState());
      }
      );
    }
  }
  void deletePost(String postid){
    FirebaseFirestore.instance
        .collection('post')
        .doc(postid)
        .delete()
    .then((value) {
      emit(SocialDeletePostSuccessState());
    });
  }
}