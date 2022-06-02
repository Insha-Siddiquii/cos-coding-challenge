import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';

abstract class VehicleRepository {
  Future<List<Vehicle>> getVehicleInspection();

  Future<bool> addVehicleInspection(Vehicle vehicle);
}
