class HotelSearchState {
  final List<Map<String, dynamic>> hotelList;

  HotelSearchState({required this.hotelList});
}

class InitialHotelSearchState extends HotelSearchState {
  InitialHotelSearchState(List<Map<String, dynamic>> hotelList)
      : super(hotelList: hotelList);
}

class SearchingHotelState extends HotelSearchState {
  SearchingHotelState(List<Map<String, dynamic>> hotelList)
      : super(hotelList: hotelList);
}
