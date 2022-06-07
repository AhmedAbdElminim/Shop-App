class UserModel {
  late String email;
  late String name;
  late String phone;
  late String uId;
  late String userImage;

  UserModel(this.email, this.name, this.phone, this.uId, this.userImage);
  UserModel.fromJson(Map<String, dynamic>? json) {
    email = json?['email'];
    name = json?['name'];
    phone = json?['phone'];
    userImage = json?['userImage'];
    uId = json?['uId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'userImage': userImage,
    };
  }
}
