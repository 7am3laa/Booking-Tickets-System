class Flight {
  int? id;
  String? from;
  String? to;
  String? fromCode;
  String? toCode;
  String? date;
  String? departureTime;
  String? flightDuration;
  String? price;

  Flight({
    this.id,
    this.from,
    this.to,
    this.date,
    this.departureTime,
    this.flightDuration,
    this.price,
    this.fromCode,
    this.toCode,
  });
}
