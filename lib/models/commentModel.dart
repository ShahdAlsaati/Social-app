class CommentModel{
  String? postId;
  String? dateTime;
  String? text;
  String? name;
  String? image;



  CommentModel({
    this.postId,
    this.text,
    this.dateTime,
    this.name,
    this.image,

  });
  CommentModel.fromJson(Map<String,dynamic>?json){
    postId=json!['postId'];
    text=json['text'];
    dateTime=json['dateTime'];
    name=json['name'];
    image=json['image'];


  }
  Map<String,dynamic>toMap(){
    return {
      'postId':postId,
      'text':text,
      'dateTime':dateTime,
      'name':name,
      'image':image,
    };
  }


}