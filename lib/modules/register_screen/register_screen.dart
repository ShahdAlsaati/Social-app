import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../../layout/social_layout.dart';
import '../../../shared/component/component.dart';
import '../../../shared/netWork/local/cach_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class RegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var nameController=TextEditingController();
    var phoneController=TextEditingController();

    return BlocProvider(
      create:(BuildContext context)=>SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterState>(
        listener:(context, state){
      if(state is SocialCreateUserSuccessState){
        CacheHelper.saveData(
            key: 'uId',
            value: state.uId).then((value){
          navigateAndFinish(context, SocialLayout());

        });
               }
      },
        builder: (context, state){
          var cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            body:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,

                              ),
                            ),
                            SizedBox (
                              height:15,
                            ),
                            Text(
                              'Register now to communicate with friends',
                              style:Theme.of(context).textTheme.bodyText1?.copyWith(
                                color:Colors.grey,
                              ),
                            ),

                            SizedBox(
                              height:15,
                            ),
                            defaultFormField(
                              controller: nameController ,
                              type: TextInputType.name,
                              label:'Name',
                              prefix: Icons.person,

                              validator: (value) {
                                if(value!.isEmpty){
                                  return 'Please enter your name';
                                }
                                else{
                                  print(value);
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },
                            ),
                            SizedBox(
                              height:30,
                            ),
                            defaultFormField(
                              controller: emailController ,
                              type: TextInputType.emailAddress,
                              label:'Email',
                              prefix: Icons.email,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return 'Email cannot be empty';
                                }
                                if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                                  return 'Please enter a valide Email ';
                                }
                                else{
                                  print(value);
                                }
                                return null;
                              },
                              onfiled: (value) {
                                print(value);
                              },

                            ),
                            SizedBox(
                              height:30,
                            ),

                            defaultFormField(
                              controller: passwordController ,
                              type: TextInputType.visiblePassword,
                              label:'password',
                              isPassword:SocialRegisterCubit.get(context).isPasswordShow,

                              prefix: Icons.lock_outline,
                              suffix:SocialRegisterCubit.get(context).suffix,
                              validator: (value) {
                                if(value!.isEmpty){

                                  return 'Password cannot be empty';}
                                // RegExp regex= new RegExp(r'^,{6,}$');
                                // if(!regex.hasMatch(value)){
                                //   return 'Password is too short';
                                // }

                                else{
                                  print(value);
                                }
                                return null;
                              },
                              suffixpressed:(){
                                SocialRegisterCubit.get(context).changePPasswordVisibility();
                              },

                            ),
                            SizedBox(
                              height:30,
                            ),
                            defaultFormField(
                              controller: phoneController ,
                              type: TextInputType.phone,
                              label:'Phone',
                              prefix: Icons.phone,

                              validator: (value) {
                                if(value!.isEmpty){
                                  return 'Please enter your phone';
                                }
                                else{
                                  print(value);
                                }
                                return null;
                              },

                            ),

                            SizedBox(
                              height:30,
                            ),
                            ConditionalBuilder(
                              condition:state is ! SocialRegisterLoadingState,
                              builder:(context)=>defaultButton(
                                onPressed: () {
                                  if(formKey.currentState!.validate()){
                                      cubit.userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    phone:phoneController.text ,
                                       );
                                  }

                                },
                                text: 'REGISTER',
                                isUppercase:true,

                              ),
                              fallback: (context)=>Center(child: CircularProgressIndicator()),),
                            Center(
                              child: defaultTextButton(

                                function: (){
                               SocialRegisterCubit.get(context).signInWithGoogle(name: nameController.text,
                                   password: passwordController.text, phone: phoneController.text).then((value){
                                     navigateAndFinish(context,SocialLayout());
                               });
                                },
                                text: 'sing in with google account',),
                            ),


                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),


          );
        },

      ),
    );
  }
}


