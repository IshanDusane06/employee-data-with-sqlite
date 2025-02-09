import 'package:employee_details_app/pages/add_emplyee_details/model/employee_details_model.dart';
import 'package:employee_details_app/pages/home_page/cubit/employee_details.state.dart';
import 'package:employee_details_app/pages/home_page/model/employee_list.model.dart';
import 'package:employee_details_app/repository/crud_employee_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListCubit extends Cubit<EmployeeDetailsList> {
  EmployeeListCubit() : super(EmployeeDetailsInitialState());

  PersistentDatabase database = PersistentDatabase();

  Future getAllEmployeeList(BuildContext context) async {
    try {
      // emit(EmployeeDetailsListLoadingState());
      // await Future.delayed(Duration(seconds: 5));
      List<EmployeeDetailsModel>? allEmployeeDetails =
          await database.getAllEmployess();
      List<EmployeeDetailsModel> currentEmployees = [];
      List<EmployeeDetailsModel> previousEmployees = [];
      if (allEmployeeDetails != null && allEmployeeDetails.isNotEmpty) {
        for (var e in allEmployeeDetails) {
          if (e.toDate != null) {
            previousEmployees.add(e);
          } else {
            currentEmployees.add(e);
          }
        }
        // var a = EmployeeDetailsListState(
        //   employeeDetailsList: EmployeeListModel(
        //     currentEmployees: [...currentEmployees],
        //     previousEmployees: [...previousEmployees],
        //   ),
        // ).hashCode;
        // var b = EmployeeDetailsListState()
        //     .copyWith(
        //       employeeDetailsList: EmployeeListModel(
        //         currentEmployees: currentEmployees,
        //         previousEmployees: previousEmployees,
        //       ),
        //     )
        //     .hashCode;
        // emit(EmployeeDetailsInitialState());
        // emit(EmployeeDetailsInitialState());
        // await Future.delayed(Duration(milliseconds: 500));
        emit(EmployeeDetailsListState().copyWith(
          employeeDetailsList: EmployeeListModel(
            currentEmployees: [...currentEmployees],
            previousEmployees: [...previousEmployees],
          ),
        )
            // EmployeeDetailsListState(
            //   employeeDetailsList: EmployeeListModel(
            //     currentEmployees: currentEmployees,
            //     previousEmployees: previousEmployees,
            //   ),
            // ),
            );
      } else if (allEmployeeDetails!.isEmpty) {
        emit(EmployeeDetailsEmptyListState());
      }
    } on FlutterError catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
