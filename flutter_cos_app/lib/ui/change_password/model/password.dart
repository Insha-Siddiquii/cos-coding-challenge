import 'package:flutter_cos_app/config/config.dart';
import 'package:formz/formz.dart';

enum PasswordValidationError { empty, inValid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return PasswordValidationError.empty;
    } else if (!FieldsRegExp.passwordRegExp.hasMatch(value)) {
      return PasswordValidationError.inValid;
    }
    return null;
  }
}
