class UserModel {
  String username;
  String prn;
  String email;
  String password;
  String mobile;
  String image;
  String uid;
  bool isAdmin;

  UserModel({
    this.isAdmin = false,
    required this.username,
    required this.prn,
    required this.email,
    required this.password,
    required this.mobile,
    required this.image,
    required this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        username: json['username'],
        prn: json['prn'],
        isAdmin: json['isAdmin'],
        email: json['email'],
        password: json['password'],
        mobile: json['mobile'],
        image: json['image'],
        uid: json['uid']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['prn'] = prn;
    data['isAdmin'] = isAdmin;
    data['email'] = email;
    data['password'] = password;
    data['mobile'] = mobile;
    data['image'] = image;
    data['uid'] = uid;
    return data;
  }
}

class CurrUser {
  static String? username;
  static String? prn;
  static String? email;
  static String? password;
  static String? mobile;
  static String? image;
  static String? uid;
  static bool? isAdmin;
}
