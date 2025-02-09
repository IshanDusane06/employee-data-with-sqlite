import 'package:employee_details_app/pages/add_emplyee_details/views/add_employee_details.dart';
import 'package:employee_details_app/pages/home_page/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter router = GoRouter(
    initialLocation: HomePage.id,
    routes: [
      GoRoute(
          path: HomePage.id,
          pageBuilder: (context, state) => const NoTransitionPage(
                child: HomePage(),
              ),
          routes: [
            GoRoute(
                path: AddEmployeeDetails.id,
                pageBuilder: (context, state) {
                  if (state.extra != null) {
                    return NoTransitionPage(
                      child: AddEmployeeDetails(
                        taskId: (state.extra! as Map)['id'],
                        employeeName: (state.extra! as Map)['employeeName'],
                        employeeRole: (state.extra! as Map)['employeeRole'],
                        fromDate: (state.extra! as Map)['fromDate'],
                        toDate: (state.extra! as Map)['toDate'],
                        isUpdate: (state.extra! as Map)['isUpdate'],
                      ),
                    );
                  } else {
                    return const NoTransitionPage(
                      child: AddEmployeeDetails(),
                    );
                  }
                }),
          ])
    ],
  );
}

/// Custom transition page with no transition.
class NoTransitionPage<T> extends CustomTransitionPage<T> {
  /// Constructor for a page with no transition functionality.
  const NoTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );

  static Widget _transitionsBuilder(
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) =>
      child;
}
