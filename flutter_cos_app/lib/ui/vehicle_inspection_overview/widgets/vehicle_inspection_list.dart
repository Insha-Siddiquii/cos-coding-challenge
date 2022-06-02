import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/bloc/vehicleinspection_bloc.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';

import 'vehicle_list_item.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({Key? key, required this.onVehicleSelected})
      : super(key: key);
  final Function(BuildContext, String, Vehicle) onVehicleSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleinspectionBloc, VehicleinspectionState>(
      bloc: VehicleinspectionBloc()..add((InspectedVehicleFetch())),
      builder: (context, state) {
        switch (state.status) {
          case VehicleListStatus.inProgress:
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.appSwatchOne,
              ),
            );
          case VehicleListStatus.complete:
            return ListView.builder(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              itemCount: state.vehicles.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    onVehicleSelected(
                        context, 'details', state.vehicles[index]);
                  },
                  child: VehicleListItem(
                    index: index,
                    vehicle: state.vehicles[index],
                  ),
                );
              },
            );
          case VehicleListStatus.failed:
            return const Center(
              child: Text(AppConstants.vehicleListError),
            );
          default:
            return Container();
        }
      },
    );
  }
}
