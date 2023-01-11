
class UserModel {
  String? Name;
  int? phone;
  String? email;
  String? uid;

  UserModel({this.uid, this.Name, this.phone, this.email});

   // receving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        Name: map['Name'],
        phone: map['phone']);
  }
  
  // sending data to over server
  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'Name': Name, 'phone': phone};
  }
}
