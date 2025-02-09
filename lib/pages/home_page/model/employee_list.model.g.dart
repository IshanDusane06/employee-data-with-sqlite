// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_list.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeListModel _$EmployeeListModelFromJson(Map<String, dynamic> json) =>
    EmployeeListModel(
      currentEmployees: (json['currentEmployees'] as List<dynamic>?)
          ?.map((e) => EmployeeDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      previousEmployees: (json['previousEmployees'] as List<dynamic>?)
          ?.map((e) => EmployeeDetailsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeListModelToJson(EmployeeListModel instance) =>
    <String, dynamic>{
      'currentEmployees': instance.currentEmployees,
      'previousEmployees': instance.previousEmployees,
    };
