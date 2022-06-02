import 'package:formz/formz.dart';

enum VehiclePhotoValidationError { empty }

class VehiclePhoto extends FormzInput<String, VehiclePhotoValidationError> {
  const VehiclePhoto.pure() : super.pure('');
  const VehiclePhoto.dirty([String value = '']) : super.dirty(value);

  @override
  VehiclePhotoValidationError? validator(String? value) {
    return null;
  }
}
