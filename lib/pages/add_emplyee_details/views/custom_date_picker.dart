import 'package:employee_details_app/pages/home_page/cubit/date_picker.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({
    super.key,
    required this.fromDate,
    this.date,
  });
  final bool fromDate;
  final String? date;

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;
  DateTime now = DateTime.now();

  @override
  void initState() {
    selectedDate = widget.date != null ? DateTime.parse(widget.date!) : null;
    super.initState();
  }

  void showDatePicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            DateTime tempSelectedDate = selectedDate ?? now;
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: const EdgeInsets.all(16),
              content: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                // height: MediaQuery.of(context).size.height * 0.55,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Preset Buttons
                    Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildPresetButton("Today", setStateDialog, () {
                              selectedDate = now;
                              tempSelectedDate = now;
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildPresetButton("Next Monday", setStateDialog,
                                () {
                              selectedDate = tempSelectedDate =
                                  _nextWeekday(now, DateTime.monday);
                              _nextWeekday(now, DateTime.monday);
                            }),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildPresetButton("Next Tuesday", setStateDialog,
                                () {
                              selectedDate = tempSelectedDate =
                                  _nextWeekday(now, DateTime.tuesday);
                            }),
                            const SizedBox(
                              width: 10,
                            ),
                            _buildPresetButton("After 1 week", setStateDialog,
                                () {
                              selectedDate = tempSelectedDate =
                                  now.add(const Duration(days: 7));
                            }),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: CalendarDatePicker(
                        initialDate: widget.fromDate
                            ? tempSelectedDate
                            : (context.watch<DateRangeCubit>().state.fromDate ??
                                DateTime(1990)),
                        firstDate: widget.fromDate
                            ? DateTime(1990)
                            : (context.watch<DateRangeCubit>().state.fromDate ??
                                DateTime(1990)),
                        lastDate: DateTime(2100),
                        onDateChanged: (date) {
                          setStateDialog(() {
                            tempSelectedDate = date;
                            selectedDate = date;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 20, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(DateFormat("d MMM y").format(tempSelectedDate),
                            style: const TextStyle(fontSize: 16)),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEDF8FF),
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
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedDate = tempSelectedDate;
                              if (widget.fromDate) {
                                BlocProvider.of<DateRangeCubit>(context)
                                    .setFromDate(
                                        selectedDate ?? tempSelectedDate);
                              } else {
                                BlocProvider.of<DateRangeCubit>(context)
                                    .setToDate(
                                        selectedDate ?? tempSelectedDate);
                              }
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Save"),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 16),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     TextButton(
                    //       onPressed: () => Navigator.pop(context),
                    //       child: const Text("Cancel"),
                    //     ),
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           selectedDate = tempSelectedDate;
                    //           if (widget.fromDate) {
                    //             BlocProvider.of<DateRangeCubit>(context)
                    //                 .setFromDate(
                    //                     selectedDate ?? tempSelectedDate);
                    //           } else {
                    //             BlocProvider.of<DateRangeCubit>(context)
                    //                 .setToDate(
                    //                     selectedDate ?? tempSelectedDate);
                    //           }
                    //         });
                    //         Navigator.pop(context);
                    //       },
                    //       child: const Text("Save"),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPresetButton(String text,
      void Function(void Function()) setStateDialog, VoidCallback onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setStateDialog(() {
            onPressed();
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[100],
          padding: const EdgeInsets.symmetric(horizontal: 12),
          // minimumSize: const Size(150, 36)
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF1DA1F2),
          ),
        ),
      ),
    );
  }

  DateTime _nextWeekday(DateTime date, int weekday) {
    int daysToAdd = (weekday - date.weekday + 7) % 7;
    return date.add(Duration(days: daysToAdd == 0 ? 7 : daysToAdd));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/svgs/calender.svg',
            height: 24,
            width: 24,
          ),
        ),
        label: Text(
          widget.fromDate ? 'From Date' : 'To Date',
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF949C9E)),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        floatingLabelStyle: const TextStyle(color: Colors.pinkAccent),
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
      validator: widget.fromDate
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a Start date';
              }
              return null;
            }
          : null,
      controller: TextEditingController(
        text: selectedDate != null
            ? DateFormat("d MMM y").format(selectedDate!)
            : "",
      ),
      onTap: () {
        if (!widget.fromDate) {
          if (context.read<DateRangeCubit>().state.fromDate == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please select From Date First',
                ),
              ),
            );
            return;
          }
        }
        showDatePicker(context);
      },
    );
  }
}
