
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/modules/Login_Screen/social_login_screen.dart';
import 'package:pro1/modules/my_profile/my_profile_screen.dart';
import 'package:pro1/shared/component/component.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../models/post_model.dart';
import '../../shared/component/constance.dart';
import '../../shared/netWork/local/cach_helper.dart';
import '../add_comment/add_comment_screen.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../save_post/save_post_screen.dart';

class settingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state)
      {

      },
      builder:(context, state)
      {
        var userModel=SocialCubit.get(context).uModel;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                InkWell(
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration:BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(
                        2
                      )
                    ) ,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                                '${userModel!.image}'
                            ),
                          ),
                          SizedBox(
                            width:30 ,
                          ),
                          Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    '${userModel.name}',
                                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                      height: 1.3,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                    size:16 ,
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    navigateTo(context, myProfileScreen());
                  },
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          navigateTo(context, savePostScreen());
                        },
                        child: Text(
                          'Saved Post ',
                        ),

                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          SignOut(context);
                        },
                        child: Text(
                          'Logout ',
                        ),

                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }


}
