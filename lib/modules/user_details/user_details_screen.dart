import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../models/post_model.dart';
import '../../shared/component/component.dart';
import '../../shared/netWork/local/cach_helper.dart';
import '../add_comment/add_comment_screen.dart';
import '../search/cubit/cubit.dart';


class userDetailScreen extends StatelessWidget {
String? uId;
userDetailScreen({
  this.uId
});
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SearchCubit.get(context).getUserDetails(uId);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context, state)
          {

          },
          builder:(context, state)
          {
            var userModel=SearchCubit.get(context).uModel;

            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height:180 ,
                        child: Stack(
                          alignment:AlignmentDirectional.bottomCenter ,
                          children: [
                            Align(
                              child: Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft:Radius.circular(4),
                                    topRight:Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${userModel!.cover}'
                                    ),
                                    fit:BoxFit.cover,
                                  ),
                                ),
                              ),
                              alignment:AlignmentDirectional.topCenter ,

                            ),
                            CircleAvatar(
                              radius: 63,
                              backgroundColor:Theme.of(context).scaffoldBackgroundColor ,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    '${userModel.image}'                               ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${userModel.name}',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          fontWeight:FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${userModel.bio}',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '${SocialCubit.get(context).countMyPost(uId)}',
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                        fontSize: 18,
                                        fontWeight:FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Post',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap:(){

                                },
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '234',
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                        fontSize: 18,
                                        fontWeight:FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'photos',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap:(){

                                },
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '1280',
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                        fontSize: 18,
                                        fontWeight:FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Follower',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap:(){

                                },
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '700',
                                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                        fontSize: 18,
                                        fontWeight:FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      style: Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap:(){

                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                      if(SocialCubit.get(context).posts.length>0)
                        ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder:(context, index)
                          { if(SocialCubit.get(context).posts[index].uId==uId)
                            return buildPostItem (SocialCubit.get(context).posts[index],index,context);
                          else{
                            return SizedBox(
                              height:1 ,
                            );
                          }
                          },
                          itemCount: SocialCubit.get(context).posts.length,
                          separatorBuilder:(context, index) =>SizedBox(
                            height:0.1 ,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },

        );
      }
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
                          SocialCubit.get(context).savePost(
                              SocialCubit.get(context).postId[index]
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                                Icons.save
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text("save")),
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
