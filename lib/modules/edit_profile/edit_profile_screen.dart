
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/component/component.dart';


class editProfileScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var BioController=TextEditingController();
    var phoneController=TextEditingController();


    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context, state) {

      },
      builder:(context, state) {
        var userModel=SocialCubit.get(context).uModel;
        var profileImage=SocialCubit.get(context).profileFile;
        var coverImage=SocialCubit.get(context).coverFile;
        ImageProvider?im;


        nameController.text=userModel!.name!;
        BioController.text=userModel.bio!;
        phoneController.text=userModel.phone!;


        return Scaffold(
            appBar: defaultAppBar(
              context: context,
              title: 'Edit Profile',

              action:[
                defaultTextButton(
                    function: (){
                           SocialCubit.get(context).updateUserData(name: nameController.text, phone: phoneController.text, bio: BioController.text);
                    },
                    text: 'Update'),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      if(state is SocialUserUpdateLaodingState)
                      LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height:180 ,
                        child: Stack(
                          alignment:AlignmentDirectional.bottomCenter ,
                          children: [
                            Align(
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  if(SocialCubit.get(context).coverFile == null)
                                    Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft:Radius.circular(4),
                                        topRight:Radius.circular(4),
                                      ),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${userModel.cover}'
                                        ),
                                        fit:BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  if(SocialCubit.get(context).coverFile != null)
                                    Container(
                                      height: 140,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft:Radius.circular(4),
                                          topRight:Radius.circular(4),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(SocialCubit.get(context).coverFile!.path),
                                          ),
                                          fit:BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  IconButton(
                                      onPressed:(){
                                        SocialCubit.get(context).pickCover();

                                      },
                                      icon: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          Icons.camera_enhance_outlined,
                                          size: 16,
                                        ),
                                      )),
                                ],
                              ),
                              alignment:AlignmentDirectional.topCenter ,

                            ),
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                if(SocialCubit.get(context).profileFile == null)
                                CircleAvatar(
                                  radius: 63,
                                  backgroundColor:Theme.of(context).scaffoldBackgroundColor ,

                                  child: CircleAvatar(

                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        '${userModel.image}'
                                    ),

                                ),),
                                if(SocialCubit.get(context).profileFile != null)
                                  CircleAvatar(
                                    radius: 63,
                                    backgroundColor:Theme.of(context).scaffoldBackgroundColor ,

                                    child: CircleAvatar(

                                      radius: 60,
                                      backgroundImage:FileImage(
                                        File(SocialCubit.get(context).profileFile!.path),
                                      ),

                                    ),),
                                 IconButton(
                                    onPressed:(){

                                      SocialCubit.get(context).pickImage();
                                              },
                                    icon: CircleAvatar(
                                      radius: 20,
                                      child: Icon(
                                        Icons.camera_enhance_outlined,
                                        size: 16,
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      if(SocialCubit.get(context).profileFile!=null||SocialCubit.get(context).coverFile!=null)
                      Row(
                        children: [
                          if(SocialCubit.get(context).profileFile!=null)
                            Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    onPressed: (){
                                      SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: BioController.text);

                                    },
                                    text: 'Upload profile '),
                                if(state is SocialUserUpdateLaodingState)
                                  SizedBox(
                                  height: 5,
                                ),
                                if(state is SocialUserUpdateLaodingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          if(SocialCubit.get(context).coverFile!=null)
                          Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                    onPressed: (){
                                      SocialCubit.get(context).uploadCoverImage(
                                          name: nameController.text,
                                          phone: phoneController.text,
                                          bio: BioController.text);
                                    },
                                    text: 'Upload cover'),
                                if(state is SocialUserUpdateLaodingState)
                                  SizedBox(
                                  height: 5,
                                ),
                                if(state is SocialUserUpdateLaodingState)
                                LinearProgressIndicator(),

                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      defaultFormField(
                        validator: (value) {
                          if(value!.isEmpty){

                            return 'Name cannot be empty';
                          }},
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'Name',
                        prefix:  Icons.person,
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        validator: (value) {
                          if(value!.isEmpty){

                            return 'Phone cannot be empty';
                          }},
                        controller: phoneController,
                        type: TextInputType.number,
                        label: 'Phone',
                        prefix:  Icons.phone,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        controller: BioController,
                        type: TextInputType.name,
                        label: 'Bio',
                        prefix:  Icons.warning_rounded,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
      },

    );
  }
}
