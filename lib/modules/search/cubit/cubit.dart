import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/modules/search/cubit/state.dart';
import '../../../models/searchModel.dart';
import '../../../models/social_user_model.dart';
import '../../../shared/netWork/local/cach_helper.dart';

class SearchCubit extends Cubit<SearchState>{

  SearchCubit() : super(SearchInitialState());
  SocialUserModel? uModel;

  static SearchCubit get(context)=> BlocProvider.of(context);
  List<SearchModel> searchModel=[];
  List<SearchModel> searchModelHistory=[];

  void search(String text) async{
    emit(SearchLoadingState());
    await FirebaseFirestore.instance
        .collection('user')
    // .where('name'.toString().toLowerCase(),isEqualTo: text)
      .get()
      .then((value) {
      searchModel=[];
        for (var element in value.docs) {
          if(element.data()['name'].toString().toLowerCase()==text)

            searchModel.add(SearchModel.fromJson(element.data()));
        }
        emit(SearchSucssesState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
  void removeUser(String? name){
   CacheHelper.removeData(
    key: name
   );

  }
  void getUserDetails(String? uId) {
    FirebaseFirestore.instance
        .collection('user')
         .doc(uId)
        .get()
         .then((value){
      uModel = SocialUserModel.fromJson(value.data());
      emit(SearchGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchGetUserErrorState());

    });
  }
}