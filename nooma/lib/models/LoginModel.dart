class LoginModel {
  final String username;
  final String userID;


  LoginModel(this.username, this.userID);

  LoginModel.fromJson(Map<String, dynamic> json)
    : username = json['username'],
      userID = json['userID'].toString();

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'userID': userID,
      };
}

