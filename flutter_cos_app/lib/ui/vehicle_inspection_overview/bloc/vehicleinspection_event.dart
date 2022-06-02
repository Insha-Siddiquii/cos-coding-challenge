part of 'vehicleinspection_bloc.dart';

abstract class VehicleinspectionEvent extends Equatable {
  const VehicleinspectionEvent();

  @override
  List<Object> get props => [];
}

class InspectedVehicleFetch extends VehicleinspectionEvent {}
