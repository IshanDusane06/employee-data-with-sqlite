import 'package:employee_details_app/pages/add_emplyee_details/cubit/add_employee_details.bloc.dart';
import 'package:employee_details_app/pages/add_emplyee_details/views/add_employee_details.dart';
import 'package:employee_details_app/pages/home_page/cubit/employee_details.bloc.dart';
import 'package:employee_details_app/pages/home_page/cubit/employee_details.state.dart';
import 'package:employee_details_app/pages/home_page/views/employee_detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  static const String id = '/home-page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<EmployeeListCubit>().getAllEmployeeList(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Add Employee Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: BlocConsumer<EmployeeListCubit, EmployeeDetailsList>(
        builder: (context, state) {
          context.watch<EmployeeListCubit>();
          if (state is EmployeeDetailsEmptyListState ||
              state is EmployeeDetailsInitialState) {
            return Center(
              child: SvgPicture.asset('assets/svgs/no_record_found.svg'),
            );
          }
          if (state is EmployeeDetailsListState) {
            final currentEmployees =
                state.employeeDetailsList?.currentEmployees;
            final previousEmployees =
                state.employeeDetailsList?.previousEmployees;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (currentEmployees?.isNotEmpty ?? false) ...[
                    Container(
                      width: double.infinity,
                      color: const Color(0xFFE5E5E5),
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Current Employee',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1DA1F2),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 0.4,
                          );
                        },
                        itemCount: currentEmployees?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.go(
                                  '${HomePage.id}/${AddEmployeeDetails.id}',
                                  extra: {
                                    'id': currentEmployees[index].id ?? '',
                                    'employeeName':
                                        currentEmployees[index].employeeName ??
                                            '',
                                    'employeeRole':
                                        currentEmployees[index].employeeRole ??
                                            '',
                                    'fromDate':
                                        currentEmployees[index].fromDate ??
                                            DateTime.now().toString(),
                                    'toDate': currentEmployees[index].toDate,
                                    'isUpdate': true,
                                  });
                            },
                            child: Dismissible(
                              key: Key(
                                  currentEmployees![index].hashCode.toString()),
                              background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SvgPicture.asset(
                                      'assets/svgs/delete_icon.svg')),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                context
                                    .read<AddEmployeeDetailsCubit>()
                                    .deleteEmployeeDetails(
                                        currentEmployees[index].id!, context);
                              },
                              child: EmployeeDetailsTile(
                                employeeName:
                                    currentEmployees[index].employeeName ?? '',
                                employeeRole:
                                    currentEmployees[index].employeeRole ?? '',
                                fromDate: currentEmployees[index].fromDate ??
                                    DateTime.now().toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  if (previousEmployees?.isNotEmpty ?? false) ...[
                    Container(
                      width: double.infinity,
                      color: const Color(0xFFE5E5E5),
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Previous Employee',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1DA1F2),
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 0.8,
                          );
                        },
                        itemCount: previousEmployees?.length ?? 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              context.go(
                                '${HomePage.id}/${AddEmployeeDetails.id}',
                                extra: {
                                  'id': previousEmployees[index].id ?? '',
                                  'employeeName':
                                      previousEmployees[index].employeeName ??
                                          '',
                                  'employeeRole':
                                      previousEmployees[index].employeeRole ??
                                          '',
                                  'fromDate':
                                      previousEmployees[index].fromDate ??
                                          DateTime.now().toString(),
                                  'toDate': previousEmployees[index].toDate,
                                  'isUpdate': true,
                                },
                              );
                            },
                            child: Dismissible(
                              background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: SvgPicture.asset(
                                      'assets/svgs/delete_icon.svg')),
                              direction: DismissDirection.endToStart,
                              key: Key(previousEmployees![index]
                                  .hashCode
                                  .toString()),
                              onDismissed: (direction) {
                                context
                                    .read<AddEmployeeDetailsCubit>()
                                    .deleteEmployeeDetails(
                                        previousEmployees[index].id!, context);
                              },
                              child: EmployeeDetailsTile(
                                employeeName:
                                    previousEmployees[index].employeeName ?? '',
                                employeeRole:
                                    previousEmployees[index].employeeRole ?? '',
                                fromDate: previousEmployees[index].fromDate ??
                                    DateTime.now().toString(),
                                toDate: previousEmployees[index].toDate,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
        listener: (BuildContext context, Object? state) {},
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add),
        onPressed: () {
          context.go('${HomePage.id}/${AddEmployeeDetails.id}');
        },
      ),
    );
  }
}
