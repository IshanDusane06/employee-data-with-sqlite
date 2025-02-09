import 'package:employee_details_app/const/employee_role.dart';
import 'package:employee_details_app/pages/add_emplyee_details/cubit/add_employee_details.bloc.dart';
import 'package:employee_details_app/pages/add_emplyee_details/model/employee_details_model.dart';
import 'package:employee_details_app/pages/add_emplyee_details/views/custom_date_picker.dart';
import 'package:employee_details_app/pages/home_page/cubit/date_picker.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class AddEmployeeDetails extends StatefulWidget {
  static const String id = 'add-employee-details-page';

  const AddEmployeeDetails({
    this.employeeName,
    this.employeeRole,
    this.fromDate,
    this.toDate,
    this.taskId,
    this.isUpdate = false,
    super.key,
  });

  final int? taskId;
  final String? employeeName;
  final String? employeeRole;
  final String? fromDate;
  final String? toDate;
  final bool isUpdate;

  @override
  State<AddEmployeeDetails> createState() => _AddEmployeeDetailsState();
}

class _AddEmployeeDetailsState extends State<AddEmployeeDetails> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _employeeNameController = TextEditingController();
  final TextEditingController _employeeRoleController = TextEditingController();
  final TextEditingController _fromDate = TextEditingController();
  final TextEditingController _toDate = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _employeeNameController.text =
        widget.employeeName != null ? widget.employeeName! : '';
    _employeeRoleController.text =
        widget.employeeRole != null ? widget.employeeRole! : '';
    _fromDate.text = widget.fromDate != null ? widget.fromDate.toString() : '';
    _toDate.text = widget.toDate != null ? widget.toDate.toString() : '';
    widget.isUpdate
        ? context
            .read<DateRangeCubit>()
            .setFromDate((DateTime.parse(widget.fromDate!)))
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeDetailsCubit(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: false,
            title: const Text(
              'Add Employee Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            automaticallyImplyLeading: false,
            actions: widget.taskId != null
                ? [
                    GestureDetector(
                        onTap: () async {
                          await context
                              .read<AddEmployeeDetailsCubit>()
                              .deleteEmployeeDetails(widget.taskId!, context);
                          context.pop();
                        },
                        child: SvgPicture.asset('assets/svgs/delete_icon.svg')),
                    const SizedBox(
                      width: 15,
                    )
                  ]
                : null,
          ),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    focusNode: _focusNode,
                    controller: _employeeNameController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/svgs/person.svg',
                          height: 24,
                          width: 24,
                        ),
                      ),
                      label: const Text(
                        'Employee name',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF949C9E)),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      floatingLabelStyle:
                          const TextStyle(color: Colors.pinkAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                    ),
                    onTap: () => _focusNode.requestFocus(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Employee Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  TextFormField(
                    controller: _employeeRoleController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: SvgPicture.asset(
                          'assets/svgs/bag.svg',
                          height: 24,
                          width: 24,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: Theme.of(context).primaryColor,
                        size: 40,
                      ),
                      label: const Text(
                        'Select Role',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF949C9E)),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      floatingLabelStyle:
                          const TextStyle(color: Colors.pinkAccent),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFE5E5E5),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a Employee Role';
                      }
                      return null;
                    },
                    readOnly: true,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        builder: (context) {
                          final roleList = Constants.employeeRoles;
                          return Container(
                            padding: const EdgeInsets.all(16),
                            height: 300,
                            child: ListView.builder(
                              itemCount: roleList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(roleList[index]),
                                  onTap: () {
                                    _employeeRoleController.text =
                                        roleList[index];
                                    context.pop();
                                  },
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: CustomDatePicker(
                          fromDate: true,
                          date: widget.fromDate,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Icon(
                        Icons.arrow_right_alt,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: CustomDatePicker(
                          fromDate: false,
                          date: widget.toDate,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFFF2F2F2),
                  width: 2.0,
                ),
              ),
            ),
            padding: const EdgeInsets.fromLTRB(25, 12, 25, 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _employeeNameController.clear();
                    _employeeRoleController.clear();
                    _fromDate.clear();
                    _toDate.clear();
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEDF8FF),
                    minimumSize: const Size(100, 40),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {}
                    if (!widget.isUpdate) {
                      await context
                          .read<AddEmployeeDetailsCubit>()
                          .submitEmployeeData(
                            _formKey,
                            EmployeeDetailsModel(
                              employeeName: _employeeNameController.text,
                              employeeRole: _employeeRoleController.text,
                              fromDate: context
                                  .read<DateRangeCubit>()
                                  .state
                                  .fromDate
                                  .toString(),
                              toDate:
                                  context.read<DateRangeCubit>().state.toDate ==
                                          null
                                      ? null
                                      : context
                                          .read<DateRangeCubit>()
                                          .state
                                          .toDate
                                          .toString(),
                            ),
                            context,
                          );
                    } else {
                      await context
                          .read<AddEmployeeDetailsCubit>()
                          .updateEmployeeDetails(
                            _formKey,
                            EmployeeDetailsModel(
                              id: widget.taskId,
                              employeeName: _employeeNameController.text,
                              employeeRole: _employeeRoleController.text,
                              fromDate: context
                                          .read<DateRangeCubit>()
                                          .state
                                          .fromDate ==
                                      null
                                  ? _fromDate.text
                                  : context
                                      .read<DateRangeCubit>()
                                      .state
                                      .fromDate
                                      .toString(),
                              toDate:
                                  context.read<DateRangeCubit>().state.toDate ==
                                          null
                                      ? _toDate.text == ''
                                          ? null
                                          : _toDate.text
                                      : context
                                          .read<DateRangeCubit>()
                                          .state
                                          .toDate
                                          .toString(),
                            ),
                            context,
                          );
                    }
                    // context.read<DateRangeCubit>().resetDates();
                    // Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
