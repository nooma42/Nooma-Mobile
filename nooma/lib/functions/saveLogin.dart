import 'package:shared_preferences/shared_preferences.dart';
import 'package:nooma/models/LoginModel.dart';

saveLogin(Map responseJSON) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();

  var username;
  if((responseJSON != null && responseJSON.isNotEmpty)) {
    username = LoginModel.fromJson(responseJSON).username;
  }
  else {
      username = "";
  }
  var userID = (responseJSON != null && responseJSON.isNotEmpty) ? LoginModel.fromJson(responseJSON).userID : "0";

  //set preferences based on values
  await preferences.setString('username', (username != null && username.length > 0) ? username : "");
  await preferences.setString('userID', (userID != null && userID.length > 0) ? userID : "");
}