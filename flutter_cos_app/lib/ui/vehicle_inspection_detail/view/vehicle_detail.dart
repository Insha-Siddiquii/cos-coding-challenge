import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/config.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/bloc/vehicleinspectionadd_bloc.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/view/vehicle_photo_uploader.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';

import 'vehicle_inspection_add.dart';

class VehicleInspectionDetail extends StatefulWidget {
  const VehicleInspectionDetail({
    Key? key,
  }) : super(key: key);
  static const routeName = '/vehicleDetails';

  @override
  State<VehicleInspectionDetail> createState() =>
      _VehicleInspectionDetailState();
}

class _VehicleInspectionDetailState extends State<VehicleInspectionDetail> {
  Vehicle vehicle = const Vehicle(
      make: '', model: '', date: '', id: '', photo: '', status: '');

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final pageType = args['pageType'] as String;

    if (pageType == 'details') {
      vehicle = args['vehicle'] as Vehicle;
    }

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
          AppConstants.cosInspection,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 320.0,
            child: pageType == 'details'
                ? Hero(
                    tag: "tag_${vehicle.id}",
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(vehicle.photo),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                : VehiclePhotoUploader(
                    onImageSelected: (String base64Image) {},
                  ),
          ),
          const SizedBox(height: 20.0),
          BlocProvider(
            create: (context) => VehicleInspectionAddBloc(),
            child: AddVehicleInspection(
              vehicle: vehicle,
              pageType: pageType,
            ),
          ),
        ],
      ),
    );
  }
}
