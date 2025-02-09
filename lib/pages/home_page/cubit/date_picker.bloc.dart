import 'package:employee_details_app/pages/home_page/cubit/date_picker.state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateRangeCubit extends Cubit<DateRangeState> {
  DateRangeCubit() : super(const DateRangeState());

  void setFromDate(DateTime date) {
    emit(state.copyWith(fromDate: date));
  }

  void setToDate(DateTime date) {
    emit(state.copyWith(toDate: date));
  }

  void resetDates() {
    emit(const DateRangeState());
  }
}
