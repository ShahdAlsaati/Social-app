abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLaodingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates {
  late final String error;

  SocialGetUserErrorState(this.error);
}
class SocialGetAllUsersLaodingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates {
  late final String error;

  SocialGetAllUsersErrorState(this.error);
}
class SocialLaodingPostState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates {
  late final String error;

  SocialGetPostErrorState(this.error);
}


class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates {
  late final String error;

  SocialLikePostErrorState(this.error);
}
class SocialNewPostState extends SocialStates{}

class SocialchangeBottonNavBarState extends SocialStates{}

class SocialUpdateUserSuccessState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

class SocialPickProfileImageState extends SocialStates {}

class SocialPickProfileImageErrorState extends SocialStates {}

class SocialPickCoverImageState extends SocialStates {}

class SocialPickCoverImageErrorState extends SocialStates {}

class SocialCoverImageSuccessState extends SocialStates {}

class SocialCoverImageFiledState extends SocialStates {}

class SocialProfileImageSuccessState extends SocialStates {}

class SocialProfileImageFiledState extends SocialStates {}

class SocialUploadProfileImageLoadingState extends SocialStates {}

class SocialUploadProfileImageSuccesState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageLoadingState extends SocialStates {}

class SocialUploadProfileCoverSuccesState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUpdateLaodingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

class SocialCreatePostLaodingState extends SocialStates {}

class SocialCreatePostSuccesState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialCreateCommentLaodingState extends SocialStates {}

class SocialCreateCommentSuccesState extends SocialStates {}

class SocialCreateCommentErrorState extends SocialStates {}

class SocialGetCommentSuccesState extends SocialStates {}

class SocialGetCommentErrorState extends SocialStates {}

class SocialPickPostImageErrorState extends SocialStates {}

class SocialPickPostSuccessImageState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialRemoveCommentState extends SocialStates {}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}

class SocialChangeModeIconState extends SocialStates {}

class SocialChangeModeState extends SocialStates {}

class SocialDeletePostSuccessState extends SocialStates {}


class PostSaveSuccessState extends SocialStates{}

class PostSaveErrorState extends SocialStates{}