class PostModel{
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  bool? isSaved;
 // late String postId;


  PostModel({
    this.name,
    this.uId,
    this.image,
    this.text,
    this.dateTime,
    this.postImage,
    this.isSaved,
    // required this.postId,
  });
  PostModel.fromJson(Map<String,dynamic>?json){
    name=json!['name'];
    uId=json['uId'];
    image=json['image'];
    text=json['text'];
    dateTime=json['dateTime'];
    postImage=json['postImage'];
    isSaved=json['isSaved'];
  }
  Map<String,dynamic>toMap(){
    return {
      'name':name,
      'uId':uId,
      'image':image,
      'text':text,
      'dateTime':dateTime,
      'postImage':postImage,
       'isSaved':isSaved,
    };
  }

}