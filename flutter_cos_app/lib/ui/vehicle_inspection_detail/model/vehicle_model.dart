import 'package:formz/formz.dart';

enum VehicleModelValidationError { empty }

class VehicleModel extends FormzInput<String, VehicleModelValidationError> {
  const VehicleModel.pure() : super.pure('');
  const VehicleModel.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleModelValidationError? validator(String? value) {
    return null;
  }
}
