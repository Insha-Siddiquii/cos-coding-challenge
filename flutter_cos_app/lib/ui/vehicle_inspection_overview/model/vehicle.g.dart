// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Vehicle _$$_VehicleFromJson(Map<String, dynamic> json) => _$_Vehicle(
      id: json['id'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      date: json['date'] as String,
      photo: json['photo'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$$_VehicleToJson(_$_Vehicle instance) =>
    <String, dynamic>{
      'id': instance.id,
      'make': instance.make,
      'model': instance.model,
      'date': instance.date,
      'photo': instance.photo,
      'status': instance.status,
    };
