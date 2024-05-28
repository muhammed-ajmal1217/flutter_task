
class UserModel{
  String? uid;
  String? name;
  String? email;
  UserModel({
    this.uid,
    this.name,
    this.email
  });
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
      uid: json['user_id'],
      name: json['name'],
      email: json['email']
    );
  }
  Map<String,dynamic>toJson(){
    return{
      'name':name,
      'email':email,
      'user_id':uid
    };
  }
}