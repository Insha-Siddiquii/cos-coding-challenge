import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_cos_app/data/http/vehicle_inspection.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';

part 'vehicleinspection_event.dart';
part 'vehicleinspection_state.dart';

class VehicleinspectionBloc
    extends Bloc<VehicleinspectionEvent, VehicleinspectionState> {
  VehicleinspectionBloc() : super(const VehicleinspectionState()) {
    on<InspectedVehicleFetch>(_callToInspectedVehicleFetch);
  }

  _callToInspectedVehicleFetch(VehicleinspectionEvent event,
      Emitter<VehicleinspectionState> emit) async {
    try {
      emit(
        state.copyWith(
          status: VehicleListStatus.inProgress,
          vehicles: [],
        ),
      );
      final vehicles = await VehicleInspectionServices().getVehicleInspection();
      emit(
        state.copyWith(
          status: VehicleListStatus.complete,
          vehicles: vehicles,
        ),
      );
    } catch (_) {
      emit(state.copyWith(
        status: VehicleListStatus.failed,
        vehicles: [],
      ));
    }
  }
}
