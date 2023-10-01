import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/component/component.dart';
import '../../models/searchModel.dart';
import '../search/cubit/cubit.dart';
import '../search/cubit/state.dart';


class searchDetailsScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var searchController=TextEditingController();

    return BlocConsumer<SearchCubit,SearchState>(
      listener: ( context, state) {  },
      builder: ( context, state) {
        return Scaffold(

          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(              // backgroundColor:Color(0xFFFFDEBD),

              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController ,
                          type: TextInputType.text,
                          label:'Search',
                          prefix: Icons.search,

                          validator: (value) {
                            if(value!.isEmpty){

                              return 'please enter text';
                            }
                            else{
                              print(value);
                            }
                            return null;
                          },
                          onSubmit: (String text){
                            SearchCubit.get(context).search(text);
                          }
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      if(state is SearchLoadingState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 15,
                      ),
                      if(state is SearchSucssesState)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context,index)=>buildUserItem(SearchCubit.get(context).searchModel[index],context),
                            separatorBuilder:(context,index)=>myDivider(),
                            itemCount:SearchCubit.get(context).searchModel.length,

                          ),
                        ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },

    );

  }
  Widget buildUserItem(SearchModel model,context)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              '${model.image}'
          ),),
        SizedBox(
          width:20 ,
        ),
        Text(
          '${model.name}',
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}
