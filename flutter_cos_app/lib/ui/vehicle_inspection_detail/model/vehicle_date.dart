import 'package:formz/formz.dart';

enum VehicleDateValidationError { empty, inValid }

class VehicleDate extends FormzInput<String, VehicleDateValidationError> {
  const VehicleDate.pure() : super.pure('');
  const VehicleDate.dirty([String value = '']) : super.dirty(value);

  @override
  VehicleDateValidationError? validator(String? value) {
    if (value!.isEmpty) {
      return VehicleDateValidationError.empty;
    }
    return null;
  }
}
