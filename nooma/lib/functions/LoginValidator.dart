class LoginValidator {

  LoginValidator();
  static String validateEmail(String value) {
    if (value.length == 0) {
      return ('Please enter your email address');
    }

    return null;
  }

  static String validatePassword(String value){
    if (value.length == 0) {
      return ('Please enter your password');
    }

    return null;
  }
}
