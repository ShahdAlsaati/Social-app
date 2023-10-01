import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme=ThemeData(
 cardColor: Color(0xff3C3F41),
  iconTheme: IconThemeData(color:Colors.white ),
  scaffoldBackgroundColor: Color(0xff0E1621),
  backgroundColor:  Color(0xff0E1621),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData (
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor:  Color(0xff0E1621),
      statusBarIconBrightness: Brightness.light,

    ),
    backgroundColor:  Color(0xff0E1621),
    elevation: 0,
  ),
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor:  Color(0xFF33739),
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20,

  ),


  textTheme: TextTheme(
    subtitle1:TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color:Colors.white,
        height: 1.3
    ) ,
      caption:TextStyle(
          color:Colors.white,
      )

  ),

);
ThemeData lightTheme=ThemeData(
  cardColor:Colors.white,

  backgroundColor:Colors.white,
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData (
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,

    ),
    backgroundColor: Colors.white,
    elevation: 0,
  ),

  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    selectedItemColor:  Colors.black,
    unselectedItemColor: Colors.grey,
    elevation: 20,
  ),
    textTheme: TextTheme(
    subtitle1:TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color:Colors.black,
      height: 1.3
    ) ,
        caption:TextStyle(
          color:Colors.black,
        )
    ),

  iconTheme: IconThemeData(color:Colors.black ),

);