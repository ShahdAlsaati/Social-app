import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro1/models/post_model.dart';
import '../../../shared/component/component.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/state.dart';
import '../../models/commentModel.dart';

class addCommentScreen extends StatelessWidget {
  String? PostIdComment;
  addCommentScreen(String postIdComment, {
     this.PostIdComment,
  });

  var textController=TextEditingController();
  var now=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getComments(
             PostIdComment
        );
        return BlocConsumer<SocialCubit,SocialStates>(
            listener:(context,state){

            },
            builder: (context,state){
              return  Scaffold(
                appBar: defaultAppBar(
                    context: context,
                    title: 'Comments'
                ),
                body:Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index)=>SizedBox(
                            height: 10,
                          ),
                          itemBuilder: (BuildContext context, int index)=>Expanded(child: buildComments(SocialCubit.get(context).Comment[index],context))
                        ,
                          itemCount:SocialCubit.get(context).Comment.length ,
                      ),
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
                                    hintText: 'type ypur comment here ...'
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: (){
                                SocialCubit.get(context).createComment(
                                  dateTime:DateTime.now().toString() ,
                                  text: textController.text,
                                  postId: PostIdComment
                                );
                              },
                              minWidth: 1,
                              child: Icon(Icons.send_outlined,
                                size: 16,
                                color: Colors.white,
                              ),),
                          )
                        ],
                      ) ,
                    ),

                  ],
                ) ,

              );
            },


        );
      }
    );
  }
Widget buildComments(CommentModel model,context)=>Card(
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
            IconButton(onPressed:(){

            },
                icon: Icon(
                  Icons.delete_forever,
                  size: 16,
                ))
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
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
            top: 5,
          ),

        ),

      ],
    ),
  ),
);

}
