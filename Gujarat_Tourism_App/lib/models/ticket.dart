class Ticket {
  final int? id;
  final String ticketId;
  final int userId;
  final int touristPlaceId;
  final String touristPlaceName;
  final DateTime visitDate;
  final int numberOfVisitors;
  final double totalPrice;
  final DateTime bookedAt;
  final String status; // 'active', 'used', 'cancelled'

  Ticket({
    this.id,
    required this.ticketId,
    required this.userId,
    required this.touristPlaceId,
    required this.touristPlaceName,
    required this.visitDate,
    required this.numberOfVisitors,
    required this.totalPrice,
    required this.bookedAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ticket_id': ticketId,
      'user_id': userId,
      'tourist_place_id': touristPlaceId,
      'tourist_place_name': touristPlaceName,
      'visit_date': visitDate.millisecondsSinceEpoch,
      'number_of_visitors': numberOfVisitors,
      'total_price': totalPrice,
      'booked_at': bookedAt.millisecondsSinceEpoch,
      'status': status,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      ticketId: map['ticket_id'],
      userId: map['user_id'],
      touristPlaceId: map['tourist_place_id'],
      touristPlaceName: map['tourist_place_name'],
      visitDate: DateTime.fromMillisecondsSinceEpoch(map['visit_date']),
      numberOfVisitors: map['number_of_visitors'],
      totalPrice: map['total_price'].toDouble(),
      bookedAt: DateTime.fromMillisecondsSinceEpoch(map['booked_at']),
      status: map['status'],
    );
  }
}
