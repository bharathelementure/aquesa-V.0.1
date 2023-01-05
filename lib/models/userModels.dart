
class UserModel {
  String? Name;
  int? phone;
  String? email;
  String? uid;

  UserModel({this.uid, this.Name, this.phone, this.email});

  // receving data from server
  UserModel.fromMap(Map<String, dynamic> json) {
    uid:
    json['uid'];
    email:
    json['email'];
    Name:
    json['Name'];
    phone:
    json['phone'];
  }

  set value(UserModel value) {}

  // sending data to over server
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'Name': Name, 'phone': phone};
  }

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
      uid: json['uid'],
      Name: json['Name'],
      email: json['email'],
      phone: json['phone']);
}
