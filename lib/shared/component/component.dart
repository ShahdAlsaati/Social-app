
import 'package:flutter/material.dart';

Widget defaultTextButton({
  required Function? function,
  required String text,

})=> TextButton(

  onPressed:(){
    function!();
  },
  child: Text(
    text.toUpperCase(),
    style: TextStyle(
      color: Colors.blue,
    ),

  ),

);

Widget defaultButton({

  double width=double.infinity,
  Color background=Colors.blue,
  bool isUppercase=true,
  double radius =10.0,
  required VoidCallback? onPressed,
  required String? text,

})=>Container(
  height: 40,
  width: width,
  child: MaterialButton(
    onPressed: onPressed,

    child: Text(
      isUppercase? text!.toUpperCase():text!,
      style: TextStyle(
        color: Colors.white
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),


);

Widget defaultFormField( {
  required TextEditingController controller,
  required TextInputType type,
  FormFieldValidator<String>? validator,

  bool isPassword = false,
  Function? onSubmit,
  //Function? onChange,
  //Function? onTap,

  required String label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixpressed,
  bool isClickable=true,
  Function? onfiled,

})=> TextFormField(
  controller: controller,
  keyboardType: TextInputType.emailAddress,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted:(s){
    onSubmit!(s);

  },
  // onChanged: (s){
  //   onChange!(s);
  //
  // },


  validator:validator,


  decoration: InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
    ),
    prefixIcon:Icon(
      prefix!,
    ),

    suffixIcon:suffix!=null?IconButton(
      onPressed:(){
        suffixpressed!();
      },
      icon: Icon(suffix,

      ), ):null,


    // fillColor:  Theme.of(context).splashColor,
    //  filled:true ,
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width:double.infinity ,
    height:1 ,
    color: Colors.grey[300],
  ),
);

void navigateTo(context,Widget)=>Navigator.push(context,
  MaterialPageRoute(
    builder:(context)=>Widget,
  ),
);
void navigateAndFinish(context,Widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder:(context)=>Widget,
  ),
      (Route<dynamic> route)=>false,
);
Widget profileImage(context){
  return Stack(
    children:<Widget> [
      CircleAvatar(
        radius:80 ,
        backgroundImage:AssetImage('assets/images/heart.jpg') ,
      ),
      Positioned(
        bottom: 5,
        right: 5,
        child: IconButton(
          icon: Icon(
            Icons.camera_alt,
            color:Theme.of(context).iconTheme.color,
          ),
          onPressed: () {

          },

        ),

      )
    ],
  );
}

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? action,
     })=>AppBar(
     leading: IconButton(
    icon: Icon(
      Icons.arrow_back_ios_new_outlined,
    ),
    onPressed: () {
      Navigator.pop(context);
    },

  ),
      titleSpacing: 5.0,
      title: Text(
          title!,
               ),
      actions:action,
);