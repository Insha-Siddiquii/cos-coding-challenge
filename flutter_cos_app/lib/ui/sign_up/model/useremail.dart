import 'package:flutter_cos_app/config/config.dart';
import 'package:formz/formz.dart';

enum UseremailValidationError { empty, inValid }

class Useremail extends FormzInput<String, UseremailValidationError> {
  const Useremail.pure() : super.pure('');
  const Useremail.dirty([String value = '']) : super.dirty(value);

  @override
  UseremailValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return UseremailValidationError.empty;
    } else if (!FieldsRegExp.emailRegExp.hasMatch(value)) {
      return UseremailValidationError.inValid;
    }
    return null;
  }
}
