// ignore_for_file: file_names

abstract class TicketsState {}

class FlightOrHotelState extends TicketsState {
  final bool isSelected;
  final bool isHotel;
  FlightOrHotelState(this.isSelected, this.isHotel);
}