import 'package:employee_details_app/pages/add_emplyee_details/cubit/add_employee_details_state.dart';
import 'package:employee_details_app/pages/add_emplyee_details/model/employee_details_model.dart';
import 'package:employee_details_app/pages/home_page/cubit/date_picker.bloc.dart';
import 'package:employee_details_app/pages/home_page/cubit/employee_details.bloc.dart';

import 'package:employee_details_app/repository/crud_employee_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeDetailsCubit extends Cubit<AddEmployeeDetailsState> {
  AddEmployeeDetailsCubit() : super(AddEmployeeDetailsInitialState());

  PersistentDatabase database = PersistentDatabase();

  Future submitEmployeeData(
    GlobalKey<FormState> formKey,
    EmployeeDetailsModel employeeDetails,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        await database.insertEmployeeDetails(employeeDetails);

        await context.read<EmployeeListCubit>().getAllEmployeeList(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employee Details added successfully'),
            backgroundColor: Colors.green,
          ),
        );
        context.read<DateRangeCubit>().resetDates();
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enable to add employee Details'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> updateEmployeeDetails(
    GlobalKey<FormState> formKey,
    EmployeeDetailsModel employeeDetails,
    BuildContext context,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        await database.updateEmployeeDetails(employeeDetails);
        await context.read<EmployeeListCubit>().getAllEmployeeList(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Employee Details updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
        context.read<DateRangeCubit>().resetDates();
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enable to edit Employee Details'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> deleteEmployeeDetails(
    int taskId,
    BuildContext context,
  ) async {
    try {
      final EmployeeDetailsModel deletedEmployeeData =
          await database.getEmployeeById(taskId);
      await database.deleteEmployeeDetails(taskId);
      await context.read<EmployeeListCubit>().getAllEmployeeList(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Text(
                'Employee Details deleted successfully',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () async {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  await database.insertEmployeeDetails(deletedEmployeeData);
                  await context
                      .read<EmployeeListCubit>()
                      .getAllEmployeeList(context);
                },
                child: Text(
                  'Undo',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
          // backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Enable to edit Employee Details'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
