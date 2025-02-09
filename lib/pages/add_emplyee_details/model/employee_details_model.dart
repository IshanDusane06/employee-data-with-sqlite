import 'package:json_annotation/json_annotation.dart';

part 'employee_details_model.g.dart';

@JsonSerializable()
class EmployeeDetailsModel {
  final int? id;
  final String? employeeName;
  final String? employeeRole;
  final String? fromDate;
  final String? toDate;

  const EmployeeDetailsModel({
    this.id,
    this.employeeName,
    this.employeeRole,
    this.fromDate,
    this.toDate,
  });

  factory EmployeeDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeDetailsModelToJson(this);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'employeeName': employeeName,
      'employeeRole': employeeRole,
      'fromDate': fromDate,
      'toDate': toDate,
    };
  }
}
