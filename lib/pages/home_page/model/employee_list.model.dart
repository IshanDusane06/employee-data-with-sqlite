import 'package:employee_details_app/pages/add_emplyee_details/model/employee_details_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_list.model.g.dart';

@JsonSerializable()
class EmployeeListModel {
  final List<EmployeeDetailsModel>? currentEmployees;
  final List<EmployeeDetailsModel>? previousEmployees;

  const EmployeeListModel({
    this.currentEmployees,
    this.previousEmployees,
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeListModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeListModelToJson(this);

  // Map<String, Object?> toMap() {
  //   return {
  //     'id': id,
  //     'title': title,
  //     'description': description,
  //     'date': date,
  //     'repeatAt': repeatAt,
  //   };
  // }
}
