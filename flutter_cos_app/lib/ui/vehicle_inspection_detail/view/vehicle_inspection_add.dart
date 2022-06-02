import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cos_app/config/constants.dart';
import 'package:flutter_cos_app/config/styles.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/bloc/vehicleinspectionadd_bloc.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/model/vehicle_date.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_detail/model/vehicle_id.dart';
import 'package:flutter_cos_app/ui/vehicle_inspection_overview/model/vehicle.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

class AddVehicleInspection extends StatefulWidget {
  const AddVehicleInspection({
    Key? key,
    required this.vehicle,
    required this.pageType,
  }) : super(key: key);

  final Vehicle vehicle;
  final String pageType;

  @override
  State<AddVehicleInspection> createState() => _AddVehicleInspectionState();
}

class _AddVehicleInspectionState extends State<AddVehicleInspection> {
  final TextEditingController _vehicleId = TextEditingController();
  final TextEditingController _vehicleMake = TextEditingController();
  final TextEditingController _vehicleModel = TextEditingController();
  final TextEditingController _vehicleDate = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    _setFields();
    super.initState();
  }

  void _setFields() {
    if (widget.pageType == 'details') {
      _vehicleId.text = widget.vehicle.id;
      _vehicleMake.text = widget.vehicle.make;
      _vehicleModel.text = widget.vehicle.model;
      _vehicleDate.text = widget.vehicle.date;
    }
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.appPrimary,
              onPrimary: AppColors.appWhite,
              surface: AppColors.appTertiary,
              onSurface: Colors.yellow,
            ),
            dialogBackgroundColor: AppColors.appTertiary,
          ),
          child: child!,
        );
      },
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _vehicleDate.text = DateFormat.yMMMd().format(_selectedDate);
      // ignore: use_build_context_synchronously
      context.read<VehicleInspectionAddBloc>().add(
            VehicleDateChanged(
              date: _vehicleDate.text,
            ),
          );
    }
  }

  _triggerFieldValidation(
    VehicleInspectionAddState state,
    BuildContext context,
  ) {
    context
        .read<VehicleInspectionAddBloc>()
        .add(VehicleIdChanged(id: state.id.value));
    context
        .read<VehicleInspectionAddBloc>()
        .add(VehicleDateChanged(date: state.date.value));

    if (state.id.valid && state.date.valid) {
      final vehicle = Vehicle(
        id: _vehicleId.text,
        make: _vehicleMake.text,
        model: _vehicleModel.text,
        date: _vehicleDate.text,
        photo: '',
        status: '',
      );
      context
          .read<VehicleInspectionAddBloc>()
          .add(VehicleInspectionSubmit(vehicle: vehicle));
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(AppConstants.vehiclInfo),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VehicleInspectionAddBloc, VehicleInspectionAddState>(
        listenWhen: (previousState, state) {
      return previousState.formStatus != state.formStatus;
    }, listener: (context, state) {
      if (state.formStatus == FormzStatus.submissionSuccess) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                  'Vehicle information saved. CoS Customer Expert will contact you soon'),
            ),
          );
      } else if (state.formStatus == FormzStatus.submissionFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(AppConstants.vehiclInfoNotSaved),
            ),
          );
      }
    }, child: BlocBuilder<VehicleInspectionAddBloc, VehicleInspectionAddState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              TextField(
                controller: _vehicleId,
                cursorWidth: 1,
                readOnly: widget.pageType == 'details',
                style: const TextStyle(
                  color: AppColors.appFocusField,
                  fontSize: 13,
                ),
                keyboardType: TextInputType.text,
                cursorColor: AppColors.appTertiary,
                maxLength: 17,
                decoration: InputDecoration(
                  counterText: "",
                  focusColor: AppColors.appTertiary,
                  labelText: AppConstants.vId,
                  labelStyle: const TextStyle(
                    color: AppColors.appTertiary,
                    fontSize: 14,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appPrimary),
                  ),
                  errorText: !(state.id.pure)
                      ? state.id.error == VehicleIdValidationError.empty
                          ? AppConstants.idRequired
                          : state.id.error == VehicleIdValidationError.inValid
                              ? AppConstants.idInvalid
                              : null
                      : null,
                ),
                onChanged: (value) => context
                    .read<VehicleInspectionAddBloc>()
                    .add(VehicleIdChanged(id: value)),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _vehicleMake,
                readOnly: widget.pageType == 'details',
                cursorWidth: 1,
                style: const TextStyle(
                  color: AppColors.appFocusField,
                  fontSize: 13,
                ),
                keyboardType: TextInputType.text,
                cursorColor: AppColors.appTertiary,
                decoration: const InputDecoration(
                  focusColor: AppColors.appTertiary,
                  labelText: AppConstants.vMake,
                  labelStyle: TextStyle(
                    color: AppColors.appTertiary,
                    fontSize: 14,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appPrimary),
                  ),
                ),
                onChanged: (value) => context
                    .read<VehicleInspectionAddBloc>()
                    .add(VehicleMakeChanged(make: value)),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _vehicleModel,
                readOnly: widget.pageType == 'details',
                cursorWidth: 1,
                style: const TextStyle(
                  color: AppColors.appFocusField,
                  fontSize: 13,
                ),
                keyboardType: TextInputType.text,
                cursorColor: AppColors.appTertiary,
                decoration: const InputDecoration(
                  focusColor: AppColors.appTertiary,
                  labelText: AppConstants.vModel,
                  labelStyle: TextStyle(
                    color: AppColors.appTertiary,
                    fontSize: 14,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appPrimary),
                  ),
                ),
                onChanged: (value) => context
                    .read<VehicleInspectionAddBloc>()
                    .add(VehicleModelChanged(model: value)),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _vehicleDate,
                readOnly: widget.pageType == 'details',
                cursorWidth: 1,
                style: const TextStyle(
                  color: AppColors.appFocusField,
                  fontSize: 13,
                ),
                keyboardType: TextInputType.datetime,
                cursorColor: AppColors.appTertiary,
                decoration: InputDecoration(
                    focusColor: AppColors.appTertiary,
                    labelText: AppConstants.vDate,
                    labelStyle: const TextStyle(
                      color: AppColors.appTertiary,
                      fontSize: 14,
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.appPrimary),
                    ),
                    errorText: !(state.date.pure)
                        ? state.date.error == VehicleDateValidationError.empty
                            ? AppConstants.dateRequired
                            : null
                        : null),
                onChanged: (value) =>
                    context.read<VehicleInspectionAddBloc>().add(
                          VehicleDateChanged(
                            date: value,
                          ),
                        ),
                onTap: () {
                  if (widget.pageType != 'details') {
                    _selectDate(context);
                  }
                },
              ),
              const SizedBox(height: 40.0),
              if (widget.pageType != 'details')
                BlocBuilder<VehicleInspectionAddBloc,
                    VehicleInspectionAddState>(
                  buildWhen: (previous, current) =>
                      previous.formStatus != current.formStatus,
                  builder: (context, state) {
                    return state.formStatus == FormzStatus.submissionInProgress
                        ? const CircularProgressIndicator(
                            color: AppColors.appSwatchOne,
                          )
                        : DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.appPrimary,
                                  AppColors.appTertiary,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                _triggerFieldValidation(state, context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                onSurface: Colors.transparent,
                                shadowColor: Colors.transparent,
                                fixedSize: const Size(450, 50),
                              ),
                              child: const Text(
                                AppConstants.vsubmit,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          );
                  },
                )
            ],
          ),
        );
      },
    ));
  }
}
