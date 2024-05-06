class FlightModel {
  String arrivalAirportName;
  String arrivalAirportId;
  String arrivalTime;
  String flightNumber;
  String departureAirportName;
  String departureAirportId;
  String departureTime;
  int price;
  String airline;
  String airlineLogo;
  int hoursOfFlightDuration;
  int minutesOfFlightDuration;
  List<dynamic> extensions;
  String travelClass;
  FlightModel({
    required this.arrivalAirportId,
    required this.extensions,
    required this.travelClass,
    required this.arrivalAirportName,
    required this.departureAirportId,
    required this.departureAirportName,
    required this.arrivalTime,
    required this.hoursOfFlightDuration,
    required this.minutesOfFlightDuration,
    required this.flightNumber,
    required this.price,
    required this.airline,
    required this.airlineLogo,
    required this.departureTime,
  });
}
