import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/models/message_model.dart';
import 'package:pro1/shared/component/component.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../models/social_user_model.dart';

class chatDetailsScreen extends StatelessWidget {
  SocialUserModel? userModel;
  chatDetailsScreen({
   this.userModel,
});
  var textController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessages(
            receiverId: userModel!.uId
        );
        return BlocConsumer<SocialCubit,SocialStates>(
            listener:(context,state){

        },
        builder: (context,state){
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title:Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            '${userModel!.image}'
                        ) ,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                          '${userModel!.name}'
                      ),

                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition:SocialCubit.get(context).messages.length>=0 ,
                  builder:(context)=> Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                    child: ListView.separated(
                        itemBuilder:(context, index) {
                          var messages =SocialCubit.get(context).messages[index];
                          if(SocialCubit.get(context).uModel!.uId==messages.senderId){
                            return buildMyMessage(messages);
                          }
                          else{
                            return buildMessage(messages);
                          }

                        } ,
                        separatorBuilder: (context, index)=>SizedBox(
                          height: 15,
                        ),
                        itemCount: SocialCubit.get(context).messages.length),
                  ),
                        if(SocialCubit.get(context).chatImageFile!= null)
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
                                      File(SocialCubit.get(context).chatImageFile!.path),
                                    ),
                                    fit:BoxFit.cover,
                                  ),
                                ),
                              ),

                              IconButton(
                                  onPressed:(){
                                    SocialCubit.get(context).removechatImage();
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white10,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child:Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15
                                  ),
                                  child: TextFormField(
                                    controller: textController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'type ypur message here ...'
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 50,
                                color: Colors.blue,
                                child: MaterialButton(
                                  onPressed: (){
                                          if(SocialCubit.get(context).chatImageFile==null){
                                            SocialCubit.get(context).sendMessage(
                                            receiverId:userModel!.uId,
                                          dateTime:DateTime.now().toString() ,
                                           text: textController.text,
                                                      );
                                                       }
                                            else{
                                            SocialCubit.get(context).uploadeChatImages(
                                              receiverId:userModel!.uId,
                                              dateTime:DateTime.now().toString() ,
                                              text: textController.text,
                                            );
                                          }


                                  },
                                  minWidth: 1,
                                  child: Icon(Icons.send_outlined,
                                    size: 16,
                                    color: Colors.white,
                                  ),),
                              ),
                              Container(
                                height: 50,
                                color: Colors.blue,
                                child: MaterialButton(
                                  onPressed: (){
                                    SocialCubit.get(context).pickchatImage();
                                  },
                                  minWidth: 1,
                                  child: Icon(Icons.image_outlined,
                                    size: 16,
                                    color: Colors.white,
                                  ),),
                              )

                            ],
                          ) ,
                        ),
                      ],

                    ),
                  ) ,
                  fallback:(context)=>Center(child: CircularProgressIndicator()),

                ),
              );
        },

        );
      }
    );
  }
  Widget buildMessage(MessageModel model)=>Align(
     alignment: AlignmentDirectional.centerStart,
  child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,

       children: [
         if(model.text!=null)
           Container(
           decoration: BoxDecoration(
             color: Colors.grey[300],
             borderRadius: BorderRadiusDirectional.only(
               bottomEnd: Radius.circular(10),
               topStart: Radius.circular(10),
               topEnd:Radius.circular(10),
             ),
           ),
           padding: EdgeInsets.symmetric(
             vertical: 5,
             horizontal: 10,
           ),
           child: Text(
               '${model.text}'
           ),
         ),
         if(model.chatImage!=''&&model.chatImage!=null)
           Padding(
             padding: const EdgeInsets.only(
                 top:15
             ),
             child: Container(
               height: 140,
               width: 100,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(
                     5
                 ),
                 image: DecorationImage(
                   image: NetworkImage(
                       '${model.chatImage}'
                   ),
                   fit:BoxFit.cover,
                 ),
               ),
             ),
           ),
       ],
     ),

   );

  Widget buildMyMessage(MessageModel model)=>Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if(model.text!=null)
      Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topStart: Radius.circular(10),
            topEnd:Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(
            '${model.text}'
        ),
      ),
      if(model.chatImage!=''&&model.chatImage!=null)
        Padding(
          padding: const EdgeInsets.only(
              top:15
          ),
          child: Container(
            height: 140,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  5
              ),
              image: DecorationImage(
                image: NetworkImage(
                    '${model.chatImage}'
                ),
                fit:BoxFit.cover,
              ),
            ),
          ),
        ),
    ],
  ),
);

}
