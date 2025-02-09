import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmployeeDetailsTile extends StatelessWidget {
  const EmployeeDetailsTile({
    required this.employeeName,
    required this.employeeRole,
    required this.fromDate,
    this.toDate,
    super.key,
  });

  final String employeeName;
  final String employeeRole;
  final String fromDate;
  final String? toDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          employeeName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          employeeRole,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(
              0xFF949C9E,
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          // '',
          toDate == null || toDate == ''
              ? 'From ${DateFormat('dd MMM, yyyy').format(DateTime.parse(fromDate))}'
              : '${DateFormat('dd MMM, yyyy').format(DateTime.parse(fromDate))} - ${DateFormat('dd MMM, yyyy').format(DateTime.parse(toDate ?? DateTime.now().toString()))}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(
              0xFF949C9E,
            ),
          ),
        )
      ]),
    );
  }
}
