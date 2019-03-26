class LoginModel {
  final String username;
  final String userID;
  final String name;
  final String email;

  LoginModel(this.username, this.userID, this.name, this.email);

  LoginModel.fromJson(Map<String, dynamic> json)
    : username = json['username'],
      userID = json['userID'].toString(),
      name = json['name'].toString(),
      email = json['email'].toString();

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'userID': userID,
        'name': name,
        'email': email,
      };
}

