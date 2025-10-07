class TouristPlace {
  final int? id;
  final String name;
  final String description;
  final String location;
  final String category;
  final double ticketPrice;
  final String imageUrl;
  final double rating;
  final String openingHours;
  final String bestTimeToVisit;

  TouristPlace({
    this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.ticketPrice,
    required this.imageUrl,
    required this.rating,
    required this.openingHours,
    required this.bestTimeToVisit,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'location': location,
      'category': category,
      'ticket_price': ticketPrice,
      'image_url': imageUrl,
      'rating': rating,
      'opening_hours': openingHours,
      'best_time_to_visit': bestTimeToVisit,
    };
  }

  factory TouristPlace.fromMap(Map<String, dynamic> map) {
    return TouristPlace(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      location: map['location'],
      category: map['category'],
      ticketPrice: map['ticket_price'].toDouble(),
      imageUrl: map['image_url'],
      rating: map['rating'].toDouble(),
      openingHours: map['opening_hours'],
      bestTimeToVisit: map['best_time_to_visit'],
    );
  }
}
