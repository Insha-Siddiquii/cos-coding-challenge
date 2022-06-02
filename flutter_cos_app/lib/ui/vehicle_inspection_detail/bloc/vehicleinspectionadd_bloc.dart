import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cos_app/data/http/vehicle_inspection.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/model/vehicle_date.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/model/vehicle_id.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/model/vehicle_make.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/model/vehicle_model.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/model/vehicle_photo.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';
import 'package:formz/formz.dart';

part 'vehicleinspectionadd_event.dart';
part 'vehicleinspectionadd_state.dart';

class VehicleInspectionAddBloc
    extends Bloc<VehicleInspectionAddEvent, VehicleInspectionAddState> {
  VehicleInspectionAddBloc() : super(const VehicleInspectionAddState()) {
    on<VehicleIdChanged>(_validateId);
    on<VehicleMakeChanged>(_validateMake);
    on<VehicleModelChanged>(_validateModel);
    on<VehicleDateChanged>(_validateDate);
    on<VehiclePhotoChanged>(_validatePhoto);
    on<VehicleInspectionSubmit>(_submit);
  }

  _validateId(VehicleIdChanged event, Emitter<VehicleInspectionAddState> emit) {
    {
      final id = VehicleId.dirty(event.id);
      return emit(state.copyWith(
        id: id,
        formStatus: Formz.validate(
            [state.date, state.make, state.model, state.photo, id]),
      ));
    }
  }

  _validateMake(
      VehicleMakeChanged event, Emitter<VehicleInspectionAddState> emit) {
    {
      final make = VehicleMake.dirty(event.make);
      return emit(state.copyWith(
        make: make,
        formStatus: Formz.validate(
            [state.date, state.id, state.model, state.photo, make]),
      ));
    }
  }

  _validateModel(
      VehicleModelChanged event, Emitter<VehicleInspectionAddState> emit) {
    {
      final model = VehicleModel.dirty(event.model);
      return emit(state.copyWith(
        model: model,
        formStatus: Formz.validate(
            [state.date, state.make, state.id, state.photo, model]),
      ));
    }
  }

  _validateDate(
      VehicleDateChanged event, Emitter<VehicleInspectionAddState> emit) {
    {
      final date = VehicleDate.dirty(event.date);
      return emit(state.copyWith(
        date: date,
        formStatus: Formz.validate(
            [state.id, state.make, state.model, state.photo, date]),
      ));
    }
  }

  _validatePhoto(
      VehiclePhotoChanged event, Emitter<VehicleInspectionAddState> emit) {
    {
      final photo = VehiclePhoto.dirty(event.photo);
      return emit(state.copyWith(
        photo: photo,
        formStatus: Formz.validate(
            [state.date, state.make, state.model, state.id, photo]),
      ));
    }
  }

  _submit(VehicleInspectionSubmit event,
      Emitter<VehicleInspectionAddState> emit) async {
    {
      emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));
      try {
        var res = await VehicleInspectionServices()
            .addVehicleInspection(event.vehicle);

        if (res) {
          return emit(
              state.copyWith(formStatus: FormzStatus.submissionSuccess));
        } else {
          return emit(
              state.copyWith(formStatus: FormzStatus.submissionFailure));
        }
      } catch (_) {
        return emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      }
    }
  }
}
