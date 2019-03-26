import 'package:shared_preferences/shared_preferences.dart';
import 'package:nooma/models/LoginModel.dart';
import 'package:nooma/globals.dart' as globals;

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
  var name = (responseJSON != null && responseJSON.isNotEmpty) ? LoginModel.fromJson(responseJSON).name: "";
  var email = (responseJSON != null && responseJSON.isNotEmpty) ? LoginModel.fromJson(responseJSON).email: "";


  //set preferences based on values
  await preferences.setString('username', (username != null && username.length > 0) ? username : "");
  await preferences.setString('userID', (userID != null && userID.length > 0) ? userID : "");
  await preferences.setString('name', (name != null && name.length > 0) ? name : "");
  await preferences.setString('email', (email != null && email.length > 0) ? email : "");

  globals.userID = userID;
  globals.username = username;
  globals.name = name;
  globals.email = email;
}