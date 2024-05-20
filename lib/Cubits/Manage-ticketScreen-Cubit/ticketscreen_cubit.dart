import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projectf/Cubits/Manage-ticketScreen-Cubit/manage_Ticket_screen_State.dart';


class TicketScreenCubit extends Cubit<TicketsState> {
  TicketScreenCubit() : super(FlightOrHotelState(true, false));

  void selectScreen(bool isSelected, bool isHotel) {
    emit(FlightOrHotelState(isSelected, isHotel));
  }
}