
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/models/social_user_model.dart';
import 'package:pro1/shared/component/component.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../chat_details/chat_details_screen.dart';

class chatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state){

      },
      builder: (context,state){
        return ConditionalBuilder(
          condition:SocialCubit.get(context).users.length>0 ,
          builder:(context)=>ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context,index)=>buildChatItem(SocialCubit.get(context).users[index],context),
            separatorBuilder: (context,index)=>myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ) ,
          fallback:(context)=>Center(child: CircularProgressIndicator()),

        );
      },


    );
  }
  Widget buildChatItem(SocialUserModel model,context)=>InkWell(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '${model.image}'
            ),),
          SizedBox(
            width:20 ,
          ),
          Text(
            '${model.name}',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
              height: 1.3,
            ),
          ),
        ],
      ),
    ),
    onTap:(){
         navigateTo(context, chatDetailsScreen(
             userModel:model,
         ));
    },
  );
}
