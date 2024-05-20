import 'package:bloc/bloc.dart';
import 'package:projectf/Cubits/hotels-Cubit/hotel_state.dart';
import 'package:projectf/DataBase/databasehelper.dart';
import 'package:projectf/DataBase/hotel_ticket.dart';

class HotelCubit extends Cubit<HotelState> {
  HotelCubit() : super(LoadingHotelState());

  DataBaseHandler dataBaseHandler = DataBaseHandler();

  getHotelsForUser(userId) async {
    try {
      emit(LoadingHotelState());
      List<Hotel> hotels = await dataBaseHandler.getHotelsForUser(userId);
      if (hotels.isNotEmpty) {
        emit(LoadedHotelState(hotels));
      } else {
        emit(EmptyHotelState());
      }
    } catch (e) {
      emit(ErrorHotelState('$e'));
    }
  }

  deleteHotelForUser(int index, int id) async {
    try {
      await dataBaseHandler.deleteHotel(index);
      List<Hotel> hotels = await dataBaseHandler.getHotelsForUser(id);
      if (hotels.isNotEmpty) {
        emit(LoadedHotelState(hotels));
      } else {
        emit(EmptyHotelState());
      }
    } catch (e) {
      emit(ErrorHotelState('$e'));
    }
  }

  addHotelForUser(String place, String des, String img, String price,
      String totalprice, int numoftic, int id) async {
    Hotel hotel = Hotel(
      idhotel: id ,
      numOfTickets: numoftic,
      place: place,
      destination:  des,
      pricehotel: price,
      totalPrice: totalprice,
      image: img,

    );
    await dataBaseHandler.saveHotel(hotel);
  }
}
