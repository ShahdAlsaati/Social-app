import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/layout/cubit/cubit.dart';
import 'package:pro1/shared/component/component.dart';
import '../modules/new_post/new_post_screen.dart';
import 'cubit/state.dart';

class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
           if(state is SocialNewPostState){
             navigateTo(context, newPostScreen());
           }
      },
      builder: (context, state) {
        var cubit=SocialCubit.get(context);
   return Scaffold(
     appBar: AppBar(

       title: Text(
        cubit.titles[cubit.currentIndex],
       ),
       actions: [
         IconButton(onPressed:(){
           SocialCubit.get(context).changeMode();

         },
             icon: Icon(
               SocialCubit.get(context).mode,             )
         ),
         IconButton(onPressed:(){

         },
             icon: Icon(
               Icons.notifications_outlined,
             ),
         ),

       ],
     ),
     body:cubit.screens[cubit.currentIndex],
     bottomNavigationBar: BottomNavigationBar(
       onTap:(index){
        cubit.changBottonNavBar(index);
       },
       currentIndex: cubit.currentIndex,

       items: [
         BottomNavigationBarItem(
           label:'Home',
             icon: Icon(
               Icons.home,
             )),
         BottomNavigationBarItem(
             label:'Chat',
             icon:  Icon(
               Icons.chat_bubble,
             )),
         BottomNavigationBarItem(
             label:'Post',
             icon:  Icon(
               Icons.add,
             )),
         BottomNavigationBarItem(
             label:'Search',
             icon:  Icon(
               Icons.search_outlined,
             )),
         BottomNavigationBarItem(
           label:'Setting',
             icon:Icon(
                 Icons.settings
             ),),
       ],

   ),

   );
      },

    );

  }
}
