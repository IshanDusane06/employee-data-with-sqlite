import 'package:employee_details_app/pages/home_page/model/employee_list.model.dart';

abstract class EmployeeDetailsList {}

class EmployeeDetailsInitialState extends EmployeeDetailsList {}

class EmployeeDetailsListLoadingState extends EmployeeDetailsList {}

class EmployeeDetailsEmptyListState extends EmployeeDetailsList {}

class EmployeeDetailsListState extends EmployeeDetailsList {
  EmployeeDetailsListState({
    this.employeeDetailsList,
  });
  final EmployeeListModel? employeeDetailsList;

  EmployeeDetailsListState copyWith({EmployeeListModel? employeeDetailsList}) {
    return EmployeeDetailsListState(employeeDetailsList: employeeDetailsList);
  }
}
