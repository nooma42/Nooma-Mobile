import 'package:test_api/test_api.dart';
import 'package:nooma/functions/RegisterValidator.dart';

void main() {

  test('Empty First Name Test', () {
    var result = RegisterValidator.validateFirstName('');
    expect(result, 'Please enter your First Name.');
  });

  test('50 character First Name (Edge Case)', () {
    var result = RegisterValidator.validateFirstName('asseocarnisanguineoviscericartilaginonervomedullar');
    expect(result, null);
  });

  test('51 character First Name (Edge Case)', () {
    var result = RegisterValidator.validateFirstName('asseocarnisanguineoviscericartilaginonervomedullary');
    expect(result, 'First Name Too Long.');
  });

  test('Empty Last Name Test', () {
    var result = RegisterValidator.validateLastName('');
    expect(result, 'Please enter your Last Name.');
  });

  test('50 character Last Name (Edge Case)', () {
    var result = RegisterValidator.validateLastName('asseocarnisanguineoviscericartilaginonervomedullar');
    expect(result, null);
  });

  test('51 character Last Name (Edge Case)', () {
    var result = RegisterValidator.validateLastName('asseocarnisanguineoviscericartilaginonervomedullary');
    expect(result, 'Last Name Too Long.');
  });

  test('Empty Email Test', () {
    var result = RegisterValidator.validateEmail('');
    expect(result, 'Please enter your Email Address.');
  });

  test('Invalid Email', () {
    var result = RegisterValidator.validateEmail('fake@.com');
    expect(result, 'Please enter a valid email address.');
  });

  test('Valid Email', () {
    var result = RegisterValidator.validateEmail('real@mail.com');
    expect(result, null);
  });

  test('Empty Password Test', () {
    var result = RegisterValidator.validatePassword('');
    expect(result, 'Your password must be at least 8 characters.');
  });

  test('8 letter password (Edge Case)', () {
    var result = RegisterValidator.validatePassword('password');
    expect(result, null);
  });

  test('7 letter password Test', () {
    var result = RegisterValidator.validatePassword('passwor');
    expect(result, 'Your password must be at least 8 characters.');
  });

  test('50 letter password (Edge Case)', () {
    var result = RegisterValidator.validatePassword('asseocarnisanguineoviscericartilaginonervomedullar');
    expect(result, null);
  });

  test('51 letter password', () {
    var result = RegisterValidator.validatePassword('asseocarnisanguineoviscericartilaginonervomedullary');
    expect(result, 'Your password must be less than 50 characters.');
  });

}