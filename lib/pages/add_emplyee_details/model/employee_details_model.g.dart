// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDetailsModel _$EmployeeDetailsModelFromJson(
        Map<String, dynamic> json) =>
    EmployeeDetailsModel(
      id: json['id'] as int?,
      employeeName: json['employeeName'] as String?,
      employeeRole: json['employeeRole'] as String?,
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
    );

Map<String, dynamic> _$EmployeeDetailsModelToJson(
        EmployeeDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeName': instance.employeeName,
      'employeeRole': instance.employeeRole,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
    };
