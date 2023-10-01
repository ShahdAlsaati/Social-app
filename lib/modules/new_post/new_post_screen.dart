import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/component/component.dart';

class newPostScreen extends StatelessWidget {
var textController=TextEditingController();
var now=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
             return Scaffold(
               appBar: defaultAppBar(
                   context: context,
                   title: 'Creat Post',
                   action:[
                     defaultTextButton(
                         function:(){
                          if(SocialCubit.get(context).postFile==null)
                            {
                              SocialCubit.get(context).createPost(
                                  dateTime: now.toString(),
                                  text: textController.text,
                              );
                            }else{
                            SocialCubit.get(context).uploadePostImages(
                                dateTime: now.toString(),
                                text: textController.text,
                            );
                          }
                         },
                         text: 'Post')
                   ]
               ),
               body: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Column(
                   children: [
                     if(state is SocialCreatePostLaodingState)
                     LinearProgressIndicator(),
                     if(state is SocialCreatePostLaodingState)
                       SizedBox(height: 10,),
                     Row(
                       children: [
                         CircleAvatar(
                           radius: 25,
                           backgroundImage: NetworkImage(
                             '${SocialCubit.get(context).uModel!.image}'
                           ),
                         ),
                         SizedBox(
                           width:20 ,
                         ),
                         Expanded(
                           child:   Text(
                         '${SocialCubit.get(context).uModel!.name}',
                             style: TextStyle(
                               height: 1.3,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),

                       ],
                     ),
                     Expanded(
                       child: TextFormField(
                         controller: textController,
                         decoration: InputDecoration(
                             hintText: 'what is on your mind ?',
                           border: InputBorder.none
                         ),
                       ),
                     ),
                     SizedBox(
                       height: 25,
                     ),
                     if(SocialCubit.get(context).postFile!= null)
                       Stack(
                       alignment: AlignmentDirectional.topEnd,
                       children: [
                           Container(
                             height: 140,
                             width: double.infinity,
                             decoration: BoxDecoration(
                               borderRadius:BorderRadius.circular(4),
                               image: DecorationImage(
                                 image: FileImage(
                                   File(SocialCubit.get(context).postFile!.path),
                                 ),
                                 fit:BoxFit.cover,
                               ),
                             ),
                           ),

                         IconButton(
                             onPressed:(){
                               SocialCubit.get(context).removePostImage();
                             },
                             icon: CircleAvatar(
                               radius: 20,
                               child: Icon(
                                 Icons.close_sharp,
                                 size: 16,
                               ),
                             )),
                       ],
                     ),
                     SizedBox(
                       height: 25,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Expanded(
                           child: TextButton(
                               onPressed:(){
                                 SocialCubit.get(context).pickPostImage();
                               },
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Icon(
                                     Icons.image_outlined
                                   ),
                                   SizedBox(
                                     width: 5,
                                   ),
                                   Text(
                                     'Add Photo'
                                   )
                                 ],
                               )),
                         ),

                         Expanded(
                           child: TextButton(
                               onPressed:(){

                               },
                               child: Text(
                               '# tags'
                               ),),),
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
