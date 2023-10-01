import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/shared/netWork/local/cach_helper.dart';
import '../../../layout/social_layout.dart';
import '../../../shared/component/component.dart';
import '../register_screen/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
class SocialLoginScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var cubit = SocialLoginCubit.get(context);

    return BlocProvider(
      create:(BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context,state) {
          if(state is SocialLoginSuccessState){
            print("hello");
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId).then((value){
                  navigateAndFinish(context, SocialLayout());
            });
          }

        },
builder:(context, state){
  return Scaffold(
  body:Padding(
    padding: const EdgeInsets.all(20.0),
    child: Center(
      child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

        Text(
        'LOGIN',
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
            'Login now to communicate with friends',
            style:Theme.of(context).textTheme.bodyText1?.copyWith(
            color:Colors.grey,
            ),
            ),


            SizedBox (
            height:20,
            ),



            defaultFormField(
            controller: emailController ,
            type: TextInputType.emailAddress,
            label:'Email',
            prefix: Icons.email,
            //   onChanged(){
            // print(v);
            // },
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

            ),
            SizedBox(
            height:30,
            ),
            defaultFormField(
            controller: passwordController ,
            type: TextInputType.visiblePassword,
            label:'password',
            isPassword:SocialLoginCubit.get(context).isPasswordShow,

            prefix: Icons.lock_outline,
            suffix:SocialLoginCubit.get(context).suffix,
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
            SocialLoginCubit.get(context).changePPasswordVisibility();
            },
            onfiled: (value) {
            print(value);
            },

            onSubmit: (value){
            if(formKey.currentState!.validate()){

            }},

            ),
            SizedBox(
            height:30,
            ),
            ConditionalBuilder(
                condition: state is !SocialLoginLoadingState,
                builder:(context){
                  return defaultButton(

                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        cubit.userLogin(
                            email: emailController.text,
                            password: passwordController.text);

                      }
                    },
                    text: 'LOGIN',
                    isUppercase:true,

                  );
                },
                fallback:(context)=>Center(child: CircularProgressIndicator())),

            SizedBox(
            height:15,),
            Row(
            mainAxisAlignment:MainAxisAlignment.center ,
            children: [
            Text(
            'don\'t have an account ?',
            style: TextStyle(
            color: Colors.black
            ),
            ),
            defaultTextButton(

            function: (){
            navigateTo(context,
            RegisterScreen(),);
            },
            text: 'Register',),
            ],
            ),



            ],
            ),
      ),
          ),
    ),
  ),


      );
},
      ),
    );  }
}
