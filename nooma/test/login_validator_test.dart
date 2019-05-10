import 'package:nooma/functions/LoginValidator.dart';
import 'package:test_api/test_api.dart';

void main() {
  test('Empty Email Test', () {
    var result = LoginValidator.validateEmail('');
    expect(result, 'Please enter your email address');
  });

  test('Empty Password Test', () {
    var result = LoginValidator.validatePassword('');
    expect(result, 'Please enter your password');
  });

  test('Valid Email Test', () {
    var result = LoginValidator.validateEmail('email@email.com');
    expect(result, null);
  });

  test('Valid Password Test', () {
    var result = LoginValidator.validatePassword('password123');
    expect(result, null);
  });

}