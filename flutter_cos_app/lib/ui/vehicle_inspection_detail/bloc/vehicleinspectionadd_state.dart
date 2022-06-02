part of 'vehicleinspectionadd_bloc.dart';

class VehicleInspectionAddState extends Equatable {
  const VehicleInspectionAddState({
    this.formStatus = FormzStatus.pure,
    this.id = const VehicleId.pure(),
    this.make = const VehicleMake.pure(),
    this.model = const VehicleModel.pure(),
    this.date = const VehicleDate.pure(),
    this.photo = const VehiclePhoto.pure(),
  });

  final FormzStatus formStatus;
  final VehicleId id;
  final VehicleMake make;
  final VehicleModel model;
  final VehicleDate date;
  final VehiclePhoto photo;

  @override
  List<Object> get props => [formStatus, id, make, model, date, photo];

  VehicleInspectionAddState copyWith(
      {formStatus, id, make, model, date, photo}) {
    return VehicleInspectionAddState(
      formStatus: formStatus ?? this.formStatus,
      id: id ?? this.id,
      model: model ?? this.model,
      make: make ?? this.make,
      date: date ?? this.date,
      photo: photo ?? this.photo,
    );
  }
}
