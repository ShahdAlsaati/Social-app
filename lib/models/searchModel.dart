class SearchModel {
  String? name;
  String? uId;
  String? image;


  SearchModel({
  this.name,
  this.uId,
  this.image,

  });
  SearchModel.fromJson(Map<String,dynamic>?json){
    name=json!['name'];
    uId=json['uId'];
    image=json['image'];
  }
  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
    };
  }

}


