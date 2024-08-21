class Usermodel {
  String? id;
  String? uid;
  String? username;
  String? email;
  String? password;
  String? usertype;

  Usermodel(
      {required this.id,
      required this.username,
      required this.uid,
      required this.email,
      required this.password,
      required this.usertype});

  Usermodel.fromJson(Map<String, dynamic> json) {
    username = json['id'];
    uid = json['uid'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    usertype = json['userType'];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'email': email,
      'username': username,
      'password': password,
      'userType': usertype
    };
  }
}
