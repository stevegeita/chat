class User {
  final String userId;
  User({this.userId});
}

class UserData {
  final String userId;
  final String fullnames;
  final String email;
  final String phone;
  final String picture;
  final String dob;
  final String gender;

  UserData({
    this.userId,
    this.dob,
    this.email,
    this.phone,
    this.fullnames,
    this.gender,
    this.picture,
  });
  Map<String, dynamic> getDataMap() {
    return {
      "userId": userId,
      "fullnames": fullnames,
      "dob": dob,
      "email": email,
      "phone": phone,
      "gender": gender,
      "picture": picture,
    };
  }
}
