import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/layout/social_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pro1/shared/bloc_observer.dart';
import 'package:pro1/shared/netWork/local/cach_helper.dart';
import 'package:pro1/style/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/state.dart';
import 'modules/Login_Screen/cubit/cubit.dart';
import 'modules/Login_Screen/social_login_screen.dart';
import 'modules/register_screen/cubit/cubit.dart';
import 'package:bloc/bloc.dart';
import 'modules/search/cubit/cubit.dart';


Future<void> _FirebaseMessagingBackgroundHandeler(RemoteMessage massege)async
 {
   print('background');
   print(massege.data.toString());


 }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token=await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event)
  {
    print('onMessage');

    print(event.data.toString());

  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('onMessageOpenedApp');

    print(event.data.toString());
  });
  FirebaseMessaging.onBackgroundMessage(_FirebaseMessagingBackgroundHandeler);
  await CacheHelper.init();
  Widget widget;
  var uid=CacheHelper.getData(key: 'uId');
  print(uid);
  if(uid!=null){
    widget=SocialLayout();

  }
  else{
    widget=SocialLoginScreen();
  }
  bool? isDark = CacheHelper.getData(key:'isDark');
  print(isDark);
  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        isDark:isDark,
        startWidget:widget ,
      ));
    },
     blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final  bool? isDark;

  MyApp({
    required this.isDark,
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context)=>SocialLoginCubit()),
          BlocProvider(
              create: (BuildContext context)=> SocialRegisterCubit()),
          BlocProvider(
              create: (BuildContext context)=> SearchCubit()),
          BlocProvider(
              create: (BuildContext context)=> SocialCubit()..getUserData()..getPosts()..getUsers()..changeMode(fromShared:isDark)),

        ],
        child:BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme:lightTheme,
              darkTheme:darkTheme,
              themeMode:SocialCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
                home:startWidget,);
          },

        )
    );
  }
}


