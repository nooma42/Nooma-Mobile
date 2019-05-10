

class RegisterValidator {

  RegisterValidator();

  static String validateFirstName(String value) {
    if (value.length == 0) {
      return ('Please enter your First Name.');
    }
    if (value.length > 50) {
      return ('First Name Too Long.');
    }
    return null;
  }

  static String validateLastName(String value) {
    if (value.length == 0) {
      return ('Please enter your Last Name.');
    }
    if (value.length > 50) {
      return ('Last Name Too Long.');
    }
    return null;
  }

  static String validateEmail(String value) {
    RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      caseSensitive: false,
      multiLine: false,
    );
    if (value.length == 0) {
      return "Please enter your Email Address.";
    }
    if (!regExp.hasMatch(value)) {
      return "Please enter a valid email address.";
    }
    return null;
  }

  static String validatePassword(String value){
    if (value.length < 8) {
      return ('Your password must be at least 8 characters.');
    }
    if (value.length > 50) {
      return ('Your password must be less than 50 characters.');
    }
    return null;
  }

}