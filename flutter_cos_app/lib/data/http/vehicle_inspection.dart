import 'package:flutter_cos_app/domain/vehicle_repository.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class VehicleInspectionServices implements VehicleRepository {
  @override
  Future<List<Vehicle>> getVehicleInspection() async {
    try {
      List<Vehicle> vehicles = [];
      Uri uri = Uri.parse('add API endpoint');
      final response = await http.get(
        uri,
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.jsonDecode(response.body);
        var list = jsonResponse["-N3Fbbn3sdn2cp0hBJdR"]["vehicles"];
        for (var item in list) {
          vehicles.add(Vehicle.fromJson(item));
        }
        return vehicles;
      } else {
        throw Exception('Failed to load vehicle inspection');
      }
    } catch (e) {
      throw Exception('Error fetching vehicle inspection');
    }
  }

  @override
  Future<bool> addVehicleInspection(Vehicle vehicle) async {
    try {
      await Future.delayed(const Duration(seconds: 3), () {
        return true;
      });
      return true;
    } catch (e) {
      throw Exception('Error adding vehicle inspection');
    }
  }
}
