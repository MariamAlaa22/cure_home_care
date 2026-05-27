import 'package:flutter_bloc/flutter_bloc.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());

  String confirmedService = '';
  String confirmedDate = '';
  String confirmedTime = '';
  String remarks = '';
  bool hasActiveBooking = false;

  void selectService(String serviceName) {
    confirmedService = serviceName;
    emit(BookingDataUpdated());
  }

  void selectDateTime(String date, String time) {
    confirmedDate = date;
    confirmedTime = time;
    emit(BookingDataUpdated());
  }

  void confirmBooking(String userRemarks) async {
    remarks = userRemarks;
    emit(BookingLoading());
    await Future.delayed(const Duration(seconds: 1));
    hasActiveBooking = true;
    emit(BookingSuccess('Your appointment for $confirmedService has been confirmed!'));
  }
}