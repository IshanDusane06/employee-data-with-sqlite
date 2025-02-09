import 'package:equatable/equatable.dart';

class DateRangeState extends Equatable {
  final DateTime? fromDate;
  final DateTime? toDate;

  const DateRangeState({this.fromDate, this.toDate});

  DateRangeState copyWith({DateTime? fromDate, DateTime? toDate}) {
    return DateRangeState(
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
    );
  }

  @override
  List<Object?> get props => [fromDate, toDate];
}
