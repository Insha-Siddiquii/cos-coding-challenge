import 'package:formz/formz.dart';

enum VehicleIdValidationError { empty, inValid }

class VehicleId extends FormzInput<String, VehicleIdValidationError> {
  const VehicleId.pure() : super.pure('');
  const VehicleId.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleIdValidationError? validator(String? value) {
    RegExp regExp = RegExp(r'^[a-ef-hj-np-tv-zA-EaF-HJ-NP-TV-Z0-9]{17}$');
    if (value!.isEmpty) {
      return VehicleIdValidationError.empty;
    } else if (!(regExp.hasMatch(value))) {
      return VehicleIdValidationError.inValid;
    }
    return null;
  }
}
