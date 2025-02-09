abstract class AddEmployeeDetailsState {}

class AddEmployeeDetailsInitialState extends AddEmployeeDetailsState {}

class AddEmployeeDetailsLoadingState extends AddEmployeeDetailsState {}

class AddEmployeeDetailsSubmitState extends AddEmployeeDetailsState {
  AddEmployeeDetailsSubmitState({
    required this.employeeName,
    required this.selectedRole,
    required this.fromDate,
    this.toDate,
  });

  final String employeeName;
  final String selectedRole;
  final DateTime fromDate;
  final DateTime? toDate;
}
