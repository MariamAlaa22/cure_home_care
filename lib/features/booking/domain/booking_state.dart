abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingDataUpdated extends BookingState {
  final String selectedService;
  final String selectedDate;
  final String selectedTime;
  final String remarks;

  BookingDataUpdated({
    this.selectedService = '',
    this.selectedDate = '',
    this.selectedTime = '',
    this.remarks = '',
  });
}

class BookingLoading extends BookingState {}
class BookingSuccess extends BookingState {
  final String message;
  BookingSuccess(this.message);
}