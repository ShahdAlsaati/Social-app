
import '../../modules/Login_Screen/social_login_screen.dart';
import '../netWork/local/cach_helper.dart';
import 'component.dart';

var ispassWord= true;

void SignOut(context){

  CacheHelper.removeData(key: 'uId').then((value){
    if(value==true)
      navigateAndFinish(context, SocialLoginScreen());
  });
}