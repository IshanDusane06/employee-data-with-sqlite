import 'package:employee_details_app/pages/add_emplyee_details/cubit/add_employee_details.bloc.dart';
import 'package:employee_details_app/pages/home_page/cubit/date_picker.bloc.dart';
import 'package:employee_details_app/pages/home_page/cubit/employee_details.bloc.dart';
import 'package:employee_details_app/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EmployeeListCubit>(
          create: (context) => EmployeeListCubit(),
        ),
        BlocProvider<AddEmployeeDetailsCubit>(
          create: (context) => AddEmployeeDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => DateRangeCubit(),
        )
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: Routes.router,
      ),
    );
  }
}
