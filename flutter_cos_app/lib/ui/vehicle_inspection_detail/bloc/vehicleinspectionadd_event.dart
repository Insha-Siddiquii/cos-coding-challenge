part of 'vehicleinspectionadd_bloc.dart';

class VehicleInspectionAddEvent extends Equatable {
  const VehicleInspectionAddEvent();

  @override
  List<Object> get props => [];
}

class VehicleIdChanged extends VehicleInspectionAddEvent {
  final String id;
  const VehicleIdChanged({required this.id});
}

class VehicleMakeChanged extends VehicleInspectionAddEvent {
  final String make;
  const VehicleMakeChanged({required this.make});
}

class VehicleModelChanged extends VehicleInspectionAddEvent {
  final String model;
  const VehicleModelChanged({required this.model});
}

class VehicleDateChanged extends VehicleInspectionAddEvent {
  final String date;
  const VehicleDateChanged({required this.date});
}

class VehiclePhotoChanged extends VehicleInspectionAddEvent {
  final String photo;
  const VehiclePhotoChanged({required this.photo});
}

class VehicleInspectionSubmit extends VehicleInspectionAddEvent {
  final Vehicle vehicle;
  const VehicleInspectionSubmit({required this.vehicle});
}
