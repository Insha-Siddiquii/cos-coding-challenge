part of 'vehicleinspection_bloc.dart';

enum VehicleListStatus { inProgress, complete, failed }

class VehicleinspectionState extends Equatable {
  const VehicleinspectionState({
    this.status = VehicleListStatus.inProgress,
    this.vehicles = const [],
  });

  final VehicleListStatus status;
  final List<Vehicle> vehicles;

  @override
  List<Object> get props => [
        status,
        vehicles,
      ];

  VehicleinspectionState copyWith({
    required VehicleListStatus status,
    List<Vehicle>? vehicles,
  }) {
    return VehicleinspectionState(
      status: status,
      vehicles: vehicles ?? this.vehicles,
    );
  }
}
