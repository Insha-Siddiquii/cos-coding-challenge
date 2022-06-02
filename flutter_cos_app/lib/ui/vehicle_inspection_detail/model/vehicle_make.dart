import 'package:formz/formz.dart';

enum VehicleMakeValidationError { empty }

class VehicleMake extends FormzInput<String, VehicleMakeValidationError> {
  const VehicleMake.pure() : super.pure('');
  const VehicleMake.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleMakeValidationError? validator(String? value) {
    return null;
  }
}
