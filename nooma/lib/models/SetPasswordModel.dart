class SetPasswordModel {
  final String userID;
  final String newPwd;
  final String oldPwd;

  SetPasswordModel(this.userID, this.newPwd, this.oldPwd);

  SetPasswordModel.fromJson(Map<String, dynamic> json)
      : userID = json['userID'].toString(),
        newPwd = json['newPwd'],
        oldPwd = json['oldPwd'];

  Map<String, dynamic> toJson() =>
      {
        'userID': userID,
        'newPwd': newPwd,
        'oldPwd': oldPwd,
      };
}