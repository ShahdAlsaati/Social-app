import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class usersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              'https://img.freepik.com/free-photo/woman-shouts-megaphone-with-copy-space_23-2148405269.jpg?w=1060'
        ),),
        SizedBox(
          width:20 ,
        ),
        Text(
          'Shahd Alsaati',
          style: TextStyle(
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
