import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/profile/view/profile.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/view/vehicle_detail.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/bloc/vehicleinspection_bloc.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/widgets/vehicle_inspection_list.dart';

class VehicleInspectionPage extends StatelessWidget {
  const VehicleInspectionPage({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const VehicleInspectionPage());
  }

  static String routeName = '/vehicleListPage';

  void _goToProfile(BuildContext context) {
    Navigator.push(context, UserProfile.route());
  }

  void _goToDetails(BuildContext context, String pageType, Vehicle vehicle) {
    Navigator.pushNamed(
      context,
      VehicleInspectionDetail.routeName,
      arguments: {
        'pageType': pageType,
        'vehicle': vehicle,
      },
    );
  }

  void _goToAdd(BuildContext context, String pageType) {
    Navigator.pushNamed(context, VehicleInspectionDetail.routeName, arguments: {
      'pageType': pageType,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                AppColors.appPrimary,
                AppColors.appTertiary,
              ],
            ),
          ),
        ),
        title: const Text(
          AppConstants.vehicleList,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: AppColors.appWhite,
                size: 30,
              ),
              onPressed: () {
                _goToProfile(context);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _goToAdd(context, 'add');
        },
        label: const Text(
          AppConstants.addInspection,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: AppColors.appWhite,
          size: 20,
        ),
        backgroundColor: AppColors.appPrimary,
      ),
      body: BlocProvider(
        create: (context) => VehicleinspectionBloc(),
        child: VehicleList(
          onVehicleSelected:
              (BuildContext context, String pageType, Vehicle vehicle) {
            _goToDetails(context, pageType, vehicle);
          },
        ),
      ),
    );
  }
}
