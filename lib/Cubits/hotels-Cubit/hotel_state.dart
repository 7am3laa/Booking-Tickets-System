import 'package:projectf/DataBase/hotel_ticket.dart';

abstract class HotelState {}

class LoadingHotelState extends HotelState {}

class LoadedHotelState extends HotelState {
  final List<Hotel> hotel;

  LoadedHotelState(this.hotel);
}

class EmptyHotelState extends HotelState {
  final String message = 'No Hotels Booked';
  EmptyHotelState();
}

class ErrorHotelState extends HotelState {
   final String errorMessage;
  ErrorHotelState(this.errorMessage);
}
