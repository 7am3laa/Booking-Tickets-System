import 'package:flutter_bloc/flutter_bloc.dart';
import 'hotel_search_state.dart';

class HotelSearchCubit extends Cubit<HotelSearchState> {
  final List<Map<String, dynamic>> _initialHotelList;

  HotelSearchCubit(this._initialHotelList)
      : super(InitialHotelSearchState(_initialHotelList));

  void search(String query) {
    if (query.isEmpty) {
      emit(InitialHotelSearchState(_initialHotelList));
    } else {
      var filteredHotels = _initialHotelList.where((hotel) =>
          hotel['name'].toString().toLowerCase().contains(query.toLowerCase()) ||
          hotel['place'].toString().toLowerCase().contains(query.toLowerCase()));
      emit(SearchingHotelState(filteredHotels.toList()));
    }
  }
}