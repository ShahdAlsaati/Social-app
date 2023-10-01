import 'package:flutter/material.dart';

class testPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemBuilder:(context, index) =>buildCommentItem(context),
            itemCount: 10,
            separatorBuilder:(context, index) =>SizedBox(
              height:10 ,
            ),
          ),
        ],
      ),
    );
  }
  Widget buildCommentItem(context)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  ''
              ),
            ),
            Column(
              children: [
                SizedBox(
                  width:20 ,
                ),
                Row(
                  children: [
                    Text(
                      'Shahd',
                      style: TextStyle(
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
                ),
                Text(
                  'Hello',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      height: 1.4
                  ),

                ),
                SizedBox(
                  width:20 ,
                ),
                IconButton(onPressed:(){
                },
                    icon: Icon(
                      Icons.delete_forever,
                      size: 16,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Text(
                  'vfhsbckjans hvabajcnkxm vhhbajwdnkxm',
                  style: Theme.of(context).textTheme.subtitle1,
                ),

              ],
            )


          ],
        ),




      ],
    ),
  );

}
