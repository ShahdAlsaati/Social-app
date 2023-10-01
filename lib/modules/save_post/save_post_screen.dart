import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/models/post_model.dart';
import 'package:pro1/shared/component/component.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../shared/netWork/local/cach_helper.dart';
import '../add_comment/add_comment_screen.dart';

class savePostScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){

      },
      builder: (context,state){

        return Scaffold(
          appBar: defaultAppBar(context: context,
          title: 'Saved posts'),
          body: (
       Column(
           children: [

             ListView.separated(
               shrinkWrap: true,
               physics: BouncingScrollPhysics(),
               itemBuilder:(context, index) =>buildPostItem(SocialCubit.get(context).savedPost[index],index,context),
               itemCount: SocialCubit.get(context).savedPost.length,
               separatorBuilder:(context, index) =>SizedBox(
                 height:10 ,
               ),
             ),
           ],
       )
          ),
        );
      },

    );
  }

  Widget buildPostItem(PostModel model,index,context)=>Card(

    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'
                ),
              ),
              SizedBox(
                width:20 ,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
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
                      ),

                      Text(
                        '${model.dateTime}',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4
                        ),

                      ),
                    ],
                  )
              ),
              SizedBox(
                width:20 ,
              ),
              PopupMenuButton(
                  icon: Icon(Icons.more_horiz),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: InkWell(
                        onTap: (){

                        },
                        child: Row(
                          children: [
                            Icon(
                                Icons.remove
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text("unsave")),
                          ],
                        ),
                      ),
                      value: 1,
                    ),
                    if(SocialCubit.get(context).posts[index].uId==CacheHelper.getData(key: 'uId'))
                      PopupMenuItem(
                        child: InkWell(
                          onTap: (){
                            SocialCubit.get(context).deletePost(
                                SocialCubit.get(context).postId[index]
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                  Icons.delete
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: Text("Delete")),
                            ],
                          ),
                        ),
                        value: 2,
                      )
                  ]
              ),
            ],
          ),
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
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.normal
              )

          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 5,
            ),
            child: Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: 6
                    ),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed:(){},
                          child: Text(
                            '#software',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: 6
                    ),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed:(){},
                          child: Text(
                            '#flutter',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                        end: 6
                    ),
                    child: Container(
                      height: 25,
                      child: MaterialButton(
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          onPressed:(){},
                          child: Text(
                            '#Dart',
                            style: Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blue,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if(model.postImage!='')
            Padding(
              padding: const EdgeInsets.only(
                  top:15
              ),
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      5
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                        '${model.postImage}'
                    ),
                    fit:BoxFit.cover,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.pink,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap:(){
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.comment_outlined,
                            size: 14,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            // '0 comments',
                            '${SocialCubit.get(context).commentsCount[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap:(){
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).uModel!.image}'
                        ),
                      ),
                      SizedBox(
                        width:15 ,
                      ),
                      Text(
                        'write a comment ',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4
                        ),

                      ),
                    ],
                  ),
                  onTap:(){
                    navigateTo(context, addCommentScreen(
                        SocialCubit.get(context).postId[index]
                    ));
                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 14,
                      color: Colors.pink,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Likes',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap:(){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postId[index]);

                },
              ),
            ],
          ),

        ],
      ),
    ),
  );
}
